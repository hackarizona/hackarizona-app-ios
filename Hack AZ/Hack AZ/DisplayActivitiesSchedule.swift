//
//  TechTalksViewController.swift
//  Hack AZ
//
//  Created by Cody Deeran on 11/9/17.
//  Copyright © 2017 Cody Deeran. All rights reserved.
//

import UIKit

class DisplayActivitiesSchedule: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var activityName = [String]()
    var activityTime = [String]()
    var activityLocation = [String]()
    let url = URL(string: "http://hackarizona.org/2017/activities2017.json")!
    
    func getEventData() -> Void{
        // Setup the url for hackAZ
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            if error != nil {
                print(error!)
            }else{
                if let urlContent = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options:JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                        if let title = self.title {
                            if title == "ACTIVITIES_FRIDAY_SCHEDULE" {
                                print("Showing Friday schedule: ")
                                if let jsonData = (jsonResult!["friday"] as? NSArray) {
                                    for index in 0...(jsonData.count-1) {
                                        self.activityName.append((jsonData[index] as? NSDictionary)?["activity"] as! String)
                                        self.activityTime.append((jsonData[index] as? NSDictionary)?["time"] as! String)
                                        self.activityLocation.append((jsonData[index] as? NSDictionary)?["location"] as! String)
                                    }
                                }
                            } else if title == "ACTIVITIES_SATURDAY_SCHEDULE" {
                                print("Showing Saturday schedule: ")
                                if let jsonData = (jsonResult!["saturday"] as? NSArray) {
                                    for index in 0...(jsonData.count-1) {
                                        self.activityName.append((jsonData[index] as? NSDictionary)?["activity"] as! String)
                                        self.activityTime.append((jsonData[index] as? NSDictionary)?["time"] as! String)
                                        self.activityLocation.append((jsonData[index] as? NSDictionary)?["location"] as! String)
                                    }
                                }
                            } else if title == "ACTIVITIES_SUNDAY_SCHEDULE" {
                                print("Showing Sunday schedule: ")
                                if let jsonData = (jsonResult!["sunday"] as? NSArray) {
                                    for index in 0...(jsonData.count-1) {
                                        self.activityName.append((jsonData[index] as? NSDictionary)?["activity"] as! String)
                                        self.activityTime.append((jsonData[index] as? NSDictionary)?["time"] as! String)
                                        self.activityLocation.append((jsonData[index] as? NSDictionary)?["location"] as! String)
                                    }
                                }
                            }
                        }
                    } catch {
                        print("JSON Processing Failed!")
                    }
                }
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "mainCell")
        cell.contentView.backgroundColor = UIColor(red: CGFloat(75)/255.0, green: CGFloat(79)/255.0, blue: CGFloat(128)/255.0, alpha: 1.0)
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = activityName[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.font = UIFont(name: "Arial", size:24.0)
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.detailTextLabel?.text = "Time: " + activityTime[indexPath.row] + "\n Location: " + activityLocation[indexPath.row]
        cell.detailTextLabel?.font = UIFont(name: "Arial", size:18.0)
        cell.detailTextLabel?.textColor = UIColor(red: CGFloat(164)/255.0, green: CGFloat(125)/255.0, blue: CGFloat(196)/255.0, alpha: 1.0)
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getEventData()
        sleep(1)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //     MARK: - Navigation
    //     In a storyboard-based application, you will often want to do a little preparation before navigation
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //         Get the new view controller using segue.destinationViewController.
    //          Pass the selected object to the new view controller.
    //    }
    
    
}

