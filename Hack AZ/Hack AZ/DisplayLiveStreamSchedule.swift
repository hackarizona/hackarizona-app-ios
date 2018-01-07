//
//  DisplayLiveStreamSchedule.swift
//  Hack AZ
//
//  Created by Cody Deeran on 1/7/18.
//  Copyright © 2018 Cody Deeran. All rights reserved.
//

import UIKit
import Alamofire
import Alamofire_Synchronous
import SwiftyJSON

class DisplayLiveStreamSchedule:UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var activityIndicator = UIActivityIndicatorView.init()
    var eventtitle = [String]()
    var time = [String]()
    var location = [String]()
    var first_description = [String]()
    var daySelected = ""
    let url = URL(string: "http://hackarizona.org/livestreamevents.json")!
    
    private func eventDataHelper(day: String!, jsonfile: JSON!) {
        for index in 0...(jsonfile[day].count-1){
            self.eventtitle.append(jsonfile[day][index]["title"].string!)
            self.time.append(jsonfile[day][index]["time"].string!)
            self.location.append(jsonfile[day][index]["location"].string!)
            self.first_description.append(jsonfile[day][index]["description"].string!)
        }
    }
    
    func getEventData() -> Void{
        // Disable caching
        URLCache.shared.removeAllCachedResponses()
        
        // Make request with Alamofire
        let response = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON()
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            self.eventDataHelper(day: self.daySelected, jsonfile: json)
            break
        case .failure(let error):
            print(error)
            break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventtitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "mainCell")
        if(eventtitle[indexPath.row] == ""){
            cell.contentView.backgroundColor = UIColor.black
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.text = "There is currently no Live Stream scheduled for this day."
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.textLabel?.font = UIFont(name: "Arial", size:24.0)
        }else{
            cell.contentView.backgroundColor = UIColor.black
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.text = eventtitle[indexPath.row]
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.textLabel?.font = UIFont(name: "Arial", size:24.0)
            cell.detailTextLabel?.numberOfLines = 0
            cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.detailTextLabel?.text = "Time: " + time[indexPath.row] + "\nLocation: " + location[indexPath.row]
            cell.detailTextLabel?.font = UIFont(name: "Arial", size:18.0)
            cell.detailTextLabel?.textColor = UIColor(red: CGFloat(86)/255.0, green: CGFloat(91)/255.0, blue: CGFloat(146)/255.0, alpha: 1.0)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let rowPressed = indexPath.row
        for id in 0...(self.eventtitle.count-1) {
            if (id == rowPressed){
                let des = first_description[id]
                let alert = UIAlertController(title: "Description", message: des , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = daySelected.uppercased()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(66)/255.0, green: CGFloat(69)/255.0, blue: CGFloat(120)/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white ]
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        activityIndicator.startAnimating()
        getEventData()
        activityIndicator.stopAnimating()
    }
    
    func startActivityIndicator(){
        self.activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.center = view.center
        activityIndicator.color = UIColor.white
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //     MARK: - Navigation
    //     In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //}
}
