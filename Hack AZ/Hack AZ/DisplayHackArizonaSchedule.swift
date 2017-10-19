//
//  DisplayHackArizonaSchedule.swift
//  Hack AZ
//
//  Created by Cody Deeran on 10/18/17.
//  Copyright © 2017 Cody Deeran. All rights reserved.
//

import UIKit

class DisplayHackArizonaSchedule: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var cellContent = [String]()
    var scheduleTime = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "mainCell")
        cell.contentView.backgroundColor = UIColor.white
        cell.textLabel?.textColor = UIColor(red: CGFloat(67)/255.0, green: CGFloat(73)/255.0, blue: CGFloat(116)/255.0, alpha: 1.0)
        cell.textLabel?.text = scheduleTime[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Arial", size:20.0)
        cell.detailTextLabel?.text = cellContent[indexPath.row]
        cell.detailTextLabel?.font = UIFont(name: "Arial", size:18.0)
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup the url for hackAZ
//        let url = URL(string: "http://hackarizona.org/2017/schedule2017.json")!
//
//        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
//
//            if error != nil {
//                print(error!)
//            }else{
//                if let urlContent = data {
//                    do {
//                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options:JSONSerialization.ReadingOptions.mutableContainers)
//                        print(jsonResult)
//                    } catch {
//                        print("JSON Processing Failed!")
//                    }
//
//                }
//            }
        
        if let title = self.title {
            if title == "FRIDAY_SCHEDULE" {
                print("Viewing Friday's schedule")
                cellContent = ["Checkin","Sponsor Showcase","Dinner", "Opening Ceremony", "Hacking Begins"]
                scheduleTime = ["5:00pm","5:00pm","6:00pm","7:00pm","8:00pm"]
            }else if title == "SATURDAY_SCHEDULE" {
                print("Viewing Saturday's schedule")
                cellContent = ["Hacking","Breakfast","Tech Talks", "Lunch", "Activities", "Workshops", "Sponsor Exhibtion/Mentoring"]
                scheduleTime = ["All Day","7:30am","All Day","12:00pm","All Day","All Day","All Day"]
            }else if title == "SUNDAY_SCHEDULE" {
                print("Viewing Sunday's schedule")
                cellContent = ["Hacking Ends","Demo & Judging","Event Concludes"]
                scheduleTime = ["9:00am","10:00am","1:00pm"]
            }
        }
    
//        }
//        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
