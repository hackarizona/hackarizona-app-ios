//
//  DisplayFirstByteSchedule.swift
//  Hack AZ
//
//  Created by Cody Deeran on 11/29/17.
//  Copyright © 2017 Cody Deeran. All rights reserved.
//

import UIKit

class DisplayFirstByteSchedule: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var workshop = [String]()
    var time = [String]()
    var location = [String]()
    let url = URL(string: "http://hackarizona.org/firstbyte.json")!
    
    fileprivate func eventDataHelper(day: String!, jsonFile: [String : Any]?) {
        if let jsonData = (jsonFile![day] as? NSArray) {
            for index in 0...(jsonData.count-1) {
                self.workshop.append((jsonData[index] as? NSDictionary)?["workshop"] as! String)
                self.time.append((jsonData[index] as? NSDictionary)?["time"] as! String)
                self.location.append((jsonData[index] as? NSDictionary)?["location"] as! String)
            }
        }
    }
    
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
                            if title == "FIRSTBYTE_FRIDAY_SCHEDULE" {
                                self.eventDataHelper(day: "friday", jsonFile: jsonResult)
                            } else if title == "FIRSTBYTE_SATURDAY_SCHEDULE" {
                                self.eventDataHelper(day: "saturday", jsonFile: jsonResult)
                            } else if title == "FIRSTBYTE_SUNDAY_SCHEDULE" {
                                self.eventDataHelper(day: "sunday", jsonFile: jsonResult)
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
        return workshop.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "mainCell")
        cell.contentView.backgroundColor = UIColor(red: CGFloat(75)/255.0, green: CGFloat(79)/255.0, blue: CGFloat(128)/255.0, alpha: 1.0)
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = workshop[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.font = UIFont(name: "Arial", size:24.0)
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.detailTextLabel?.text = "Time: " + time[indexPath.row] + "\nLocation: " + location[indexPath.row]
        cell.detailTextLabel?.font = UIFont(name: "Arial", size:18.0)
        cell.detailTextLabel?.textColor = UIColor.black
        //cell.detailTextLabel?.textColor = UIColor(red: CGFloat(164)/255.0, green: CGFloat(125)/255.0, blue: CGFloat(196)/255.0, alpha: 1.0)
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
