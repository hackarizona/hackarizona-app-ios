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
    var first_description = [String]()
    var daySelected = ""
    let url = URL(string: "http://hackarizona.org/activities.json")!
    
    private func eventDataHelper(day: String!, jsonFile: [String : Any]?) {
        if let jsonData = (jsonFile![day] as? NSArray) {
            for index in 0...(jsonData.count-1) {
                self.activityName.append((jsonData[index] as? NSDictionary)?["activity"] as! String)
                self.activityTime.append((jsonData[index] as? NSDictionary)?["time"] as! String)
                self.activityLocation.append((jsonData[index] as? NSDictionary)?["location"] as! String)
                self.first_description.append((jsonData[index] as? NSDictionary)?["description"] as! String)
            }
        }
    }
    
    func getEventData() -> Void{
        // Setup the url for hackAZ
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 60.0)
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
            if error != nil {
                print(error!)
            }else{
                if let urlContent = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options:JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                        self.eventDataHelper(day: self.daySelected, jsonFile: jsonResult)
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
        cell.contentView.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = activityName[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.font = UIFont(name: "Arial", size:24.0)
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.detailTextLabel?.text = "Time: " + activityTime[indexPath.row] + "\nLocation: " + activityLocation[indexPath.row]
        cell.detailTextLabel?.font = UIFont(name: "Arial", size:18.0)
        //cell.detailTextLabel?.textColor = UIColor.black
        cell.detailTextLabel?.textColor = UIColor(red: CGFloat(110)/255.0, green: CGFloat(115)/255.0, blue: CGFloat(180)/255.0, alpha: 1.0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let rowPressed = indexPath.row
        for id in 0...(self.activityName.count-1) {
            if (id == rowPressed){
                let des = first_description[id]
                if des == "" {
                    let alert = UIAlertController(title: "Description", message: "Description is unavailable at this time" , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Description", message: des , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
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
