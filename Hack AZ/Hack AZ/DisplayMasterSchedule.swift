//
//  DisplaySchedule.swift
//  Hack AZ
//
//  Created by Cody Deeran on 11/19/17.
//  Copyright © 2017 Cody Deeran. All rights reserved.
//

import UIKit
import Alamofire
import Alamofire_Synchronous
import SwiftyJSON

class DisplayMasterSchedule: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var activityIndicator = UIActivityIndicatorView.init()
    var eventType = [String]()
    var eventTitle = [String]()
    var eventSubTitle = [String]()
    var day = [String]()
    var time = [String]()
    var location = [String]()
    var first_description = [String]()
    var daySelected = ""
    let url = URL(string: "http://hackarizona.org/masterschedule.json")!
    
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
        return eventType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "mainCell")
        cell.contentView.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.white
        if eventType[indexPath.row] == "required" {
            cell.textLabel?.text = "\u{1F335}" + "\t " +  eventTitle[indexPath.row]
            if eventSubTitle[indexPath.row] != "" {
                cell.textLabel?.text = "\u{1F335}" + "\t " +  eventTitle[indexPath.row] + "\n" + "\t " + eventSubTitle[indexPath.row]
            }
        }
        if eventType[indexPath.row] == "livestream" {
            cell.textLabel?.text = "\u{1F4FA}" + "\t " +  eventTitle[indexPath.row]
            if eventSubTitle[indexPath.row] != "" {
                cell.textLabel?.text = "\u{1F4FA}" + "\t " +  eventTitle[indexPath.row] + "\n" + "\t " + eventSubTitle[indexPath.row]
            }
        }
        if eventType[indexPath.row] == "food"{
            let food = eventTitle[indexPath.row]
            if food.lowercased() == "breakfast"{
                cell.textLabel?.text =  "\u{2615}" + "\t " +  eventTitle[indexPath.row]
            } else if food.lowercased() == "lunch"{
                cell.textLabel?.text =  "\u{1F96A}" + "\t " +  eventTitle[indexPath.row]
            } else if food.lowercased() == "dinner"{
                cell.textLabel?.text =  "\u{1F32E}" + "\t " +  eventTitle[indexPath.row]
            }
        }
        if eventType[indexPath.row] == "activity"{
            cell.textLabel?.text =  "\u{1F3C3}\u{200D}\u{2642}\u{FE0F}" + "\t " + eventTitle[indexPath.row]
            if eventSubTitle[indexPath.row] != "" {
                cell.textLabel?.text = "\u{1F3C3}\u{200D}\u{2642}\u{FE0F}" + "\t " +  eventTitle[indexPath.row] + "\n" + "\t " + eventSubTitle[indexPath.row]
            }
        }
        if eventType[indexPath.row] == "techtalk"{
            cell.textLabel?.text = "\u{1F468}\u{200D}\u{1F4BB}" + "\t " + eventTitle[indexPath.row]
            if eventSubTitle[indexPath.row] != "" {
                cell.textLabel?.text = "\u{1F468}\u{200D}\u{1F4BB}" + "\t " +  eventTitle[indexPath.row] + "\n" + "\t " + eventSubTitle[indexPath.row]
            }
        }
        if eventType[indexPath.row] == "firstbyte"{
            cell.textLabel?.text = "\u{1F469}\u{200D}\u{1F3EB}" + "\t " + eventTitle[indexPath.row]
            if eventSubTitle[indexPath.row] != "" {
                cell.textLabel?.text = "\u{1F469}\u{200D}\u{1F3EB}" + "\t " +  eventTitle[indexPath.row] + "\n" + "\t " + eventSubTitle[indexPath.row]
            }
        }
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.font = UIFont(name: "Arial", size:24.0)
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.detailTextLabel?.text = "\t Time: " + time[indexPath.row] + "\n" + "\t Location: " + location[indexPath.row]
        cell.detailTextLabel?.font = UIFont(name: "Arial", size:18.0)
        cell.detailTextLabel?.textColor = UIColor(red: CGFloat(75)/255.0, green: CGFloat(79)/255.0, blue: CGFloat(128)/255.0, alpha: 1.0)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let rowPressed = indexPath.row
        for id in 0...(self.eventType.count-1) {
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "KEY", style: .plain, target: self, action: #selector(emojiKey))
        activityIndicator.startAnimating()
        getEventData()
        activityIndicator.stopAnimating()
//        sleep(1)
        // Do any additional setup after loading the view.
    }
    @objc func emojiKey(sender: UIBarButtonItem) {
        let details = "\u{1F335}: Hack Arizona General Event\n\u{1F4FA}: Live Stream\n\u{2615}: Breakfast\n\u{1F96A}: Lunch\n\u{1F32E}: Dinner\n\u{1F3C3}\u{200D}\u{2642}\u{FE0F}: Activity\n\u{1F468}\u{200D}\u{1F4BB}: Tech Talk\n\u{1F469}\u{200D}\u{1F3EB}: firstByte Workshop\n\n Click on an event to view a description"
        let alert = UIAlertController(title: "KEY", message: details , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func startActivityIndicator(){
        self.activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.center = view.center
        activityIndicator.color = UIColor.white
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func stopActivityIndicator(){
        self.activityIndicator.stopAnimating()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

