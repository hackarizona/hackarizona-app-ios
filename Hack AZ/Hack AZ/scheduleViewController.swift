//
//  TechTalksVC.swift
//  Hack AZ
//
//  Created by Cody Deeran on 11/5/17.
//  Copyright © 2017 Cody Deeran. All rights reserved.
//

import UIKit
import Alamofire
import Alamofire_Synchronous
import SwiftyJSON

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellContent = ["Friday","Saturday","Sunday"]
    var eventType = [String]()
    var eventTitle = [String]()
    var eventSubTitle = [String]()
    var day = [String]()
    var time = [String]()
    var location = [String]()
    var first_description = [String]()
    var daySelected = ""
    var timedOut = false
    let url = URL(string: "http://hackarizona.org/masterschedule.json")!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContent.count
    }
    
    private func goToSegue(segue: String!, cell: UITableViewCell?) {
            self.performSegue(withIdentifier: segue, sender: cell)
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
               self.performSegue(withIdentifier: "ScheduleFridaySegue", sender: cellPressed)
            }else {
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                timedOut = false
            }
        }else if rowPressed == 1 {
            self.daySelected = "saturday"
            getEventData()
            if !timedOut {
                self.performSegue(withIdentifier: "ScheduleSaturdaySegue", sender: cellPressed)
            }else {
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                timedOut = false
            }
        }else if rowPressed == 2 {
            self.daySelected = "sunday"
            getEventData()
            if !timedOut {
                self.performSegue(withIdentifier: "ScheduleSundaySegue", sender: cellPressed)
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
        cell.textLabel?.textColor = UIColor(red: CGFloat(75)/255.0, green: CGFloat(79)/255.0, blue: CGFloat(128)/255.0, alpha: 1.0)
        cell.textLabel?.text = cellContent[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Arial", size:36.0)
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "SCHEDULE"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(66)/255.0, green: CGFloat(69)/255.0, blue: CGFloat(120)/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white ]
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
      MARK: - Navigation
     
      In a storyboard-based application, you will often want to do a little preparation before navigation
 */
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ScheduleFridaySegue" {
            let tempController = segue.destination as! UINavigationController
            let masterScheduleViewController = tempController.topViewController as! DisplayMasterSchedule
            passDataToUIController(vc: masterScheduleViewController)
        }else if segue.identifier == "ScheduleSaturdaySegue" {
            let tempController = segue.destination as! UINavigationController
            let masterScheduleViewController = tempController.topViewController as! DisplayMasterSchedule
            passDataToUIController(vc: masterScheduleViewController)
        }else if segue.identifier == "ScheduleSundaySegue" {
            let tempController = segue.destination as! UINavigationController
            let masterScheduleViewController = tempController.topViewController as! DisplayMasterSchedule
            passDataToUIController(vc: masterScheduleViewController)
        }
     }
    
    private func passDataToUIController(vc: DisplayMasterSchedule){
        vc.daySelected = self.daySelected
        vc.eventType = self.eventType
        vc.eventTitle = self.eventTitle
        vc.eventSubTitle = self.eventSubTitle
        vc.day = self.day
        vc.time = self.time
        vc.location = self.location
        vc.first_description = self.first_description
    }
    
    private func eventDataHelper(day: String!, jsonfile: JSON!) {
        for index in 0...(jsonfile[day].count-1){
            self.eventType.append(jsonfile[day][index]["eventtype"].string!)
            self.eventTitle.append(jsonfile[day][index]["eventtitle"].string!)
            self.eventSubTitle.append(jsonfile[day][index]["subtitle"].string!)
            self.day.append(jsonfile[day][index]["day"].string!)
            self.time.append(jsonfile[day][index]["time"].string!)
            self.location.append(jsonfile[day][index]["location"].string!)
            self.first_description.append(jsonfile[day][index]["description"].string!)
        }
    }
    
    func getEventData() -> Void{
        // Disable caching
        URLCache.shared.removeAllCachedResponses()
        
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
    

}


