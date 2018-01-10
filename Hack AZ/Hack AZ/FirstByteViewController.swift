//
//  FirstByteViewController.swift
//  Hack AZ
//
//  Created by Cody Deeran on 11/29/17.
//  Copyright © 2017 Cody Deeran. All rights reserved.
//

import UIKit
import Alamofire
import Alamofire_Synchronous
import SwiftyJSON

class FirstByteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellContent = ["Friday","Saturday","Sunday"]
    var workshop = [String]()
    var time = [String]()
    var location = [String]()
    var first_description = [String]()
    var daySelected = ""
    var timedOut = false
    let url = URL(string: "http://hackarizona.org/firstbyte.json")!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContent.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let rowPressed = indexPath.row
        let cellPressed = tableView.cellForRow(at: indexPath)
        let alert = UIAlertController(title: "Error", message: "Network request timed out. Please try again" , preferredStyle: .alert)
        if rowPressed == 0{
            self.daySelected = "friday"
            getEventData()
            if !timedOut {
                self.performSegue(withIdentifier: "FirstByteFridaySegue", sender: cellPressed)
            }else {
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                timedOut = false
            }
        }else if rowPressed == 1 {
            self.daySelected = "saturday"
            getEventData()
            if !timedOut {
                self.performSegue(withIdentifier: "FirstByteSaturdaySegue", sender: cellPressed)
            }else {
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                timedOut = false
            }
        }else if rowPressed == 2 {
            self.daySelected = "sunday"
            getEventData()
            if !timedOut {
                self.performSegue(withIdentifier: "FirstByteSundaySegue", sender: cellPressed)
            }else {
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                timedOut = false
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "mainCell")
        cell.contentView.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor(red: CGFloat(86)/255.0, green: CGFloat(91)/255.0, blue: CGFloat(146)/255.0, alpha: 1.0)
        cell.textLabel?.text = cellContent[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Arial", size:28.0)
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(66)/255.0, green: CGFloat(69)/255.0, blue: CGFloat(120)/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white ]
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "MORE", style: .plain, target: self, action: #selector(firstByteInfo))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    @objc func firstByteInfo(sender: UIBarButtonItem) {
        let option = "Would you like to view the full more detailed schedule of firstByte?"
        let alert = UIAlertController(title: nil, message: option , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            if let url = URL(string: "https://first-byte.org/hackarizona#schedule"){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FirstByteFridaySegue" {
            let tempController = segue.destination as! UINavigationController
            let masterScheduleViewController = tempController.topViewController as! DisplayFirstByteSchedule
            passDataToUIController(vc: masterScheduleViewController)
        }else if segue.identifier == "FirstByteSaturdaySegue" {
            let tempController = segue.destination as! UINavigationController
            let masterScheduleViewController = tempController.topViewController as! DisplayFirstByteSchedule
            passDataToUIController(vc: masterScheduleViewController)
        }else if segue.identifier == "FirstByteSundaySegue" {
            let tempController = segue.destination as! UINavigationController
            let masterScheduleViewController = tempController.topViewController as! DisplayFirstByteSchedule
            passDataToUIController(vc: masterScheduleViewController)
        }
    }
    
    private func eventDataHelper(day: String!, jsonfile: JSON!) {
        for index in 0...(jsonfile[day].count-1){
            self.workshop.append(jsonfile[day][index]["workshop"].string!)
            self.time.append(jsonfile[day][index]["time"].string!)
            self.location.append(jsonfile[day][index]["location"].string!)
            self.first_description.append(jsonfile[day][index]["description"].string!)
        }
    }
    
    func getEventData() -> Void{
        // Make request with Alamofire
        let response = Alamofire.request(URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 5)).validate().responseJSON()
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            self.eventDataHelper(day: self.daySelected, jsonfile: json)
            break
        case .failure(let error):
            print(error)
            if error._code == NSURLErrorTimedOut || error._code == NSURLErrorNotConnectedToInternet {
                self.timedOut = true
            }
            break
        }
    }
    
    private func passDataToUIController(vc: DisplayFirstByteSchedule){
        vc.daySelected = self.daySelected
        vc.workshop = self.workshop
        vc.time = self.time
        vc.location = self.location
        vc.first_description = self.first_description
    }
    
}
