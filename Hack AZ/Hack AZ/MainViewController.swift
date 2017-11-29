//
//  ViewController.swift
//  Hack AZ
//
//  Created by Cody Deeran on 10/1/17.
//  Copyright © 2017 Cody Deeran. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellContent = ["Schedule","Events","Map","Live Stream","Mentor Hub","Social Media"]
    let url = URL(string: "http://hackarizona.org/livestream.json")!
    var liveStreamUrl = ""
    
    func getLiveStreamLink() -> Void {
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            if error != nil {
                print(error!)
            }else{
                if let urlContent = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options:JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                        if let jsonData = (jsonResult!["livestream"] as? NSArray) {
                            self.liveStreamUrl = (jsonData[0] as? NSDictionary)?["link"] as! String
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
        return cellContent.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let rowPressed = indexPath.row
        let cellPressed = tableView.cellForRow(at: indexPath)
        let alert = UIAlertController(title: "Loading...", message: "", preferredStyle: .alert)
        if rowPressed == 0{
            self.performSegue(withIdentifier: "scheduleSegue", sender: cellPressed)
        }else if rowPressed == 1 {
            self.performSegue(withIdentifier: "eventsSegue", sender: cellPressed)
        }else if rowPressed == 2 {
            self.performSegue(withIdentifier: "mapSegue", sender: cellPressed)
        }else if rowPressed == 3 {
            self.present(alert, animated: true, completion: nil)
            let dismissAlert = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: dismissAlert) {
                // Your code with delay
                self.dismiss(animated: true, completion: nil)
                if let streamUrl = URL(string: self.liveStreamUrl){
                    UIApplication.shared.open(streamUrl, options: [:], completionHandler: nil)
                }
            }
        }else if rowPressed == 4 {
            let errorAlert = UIAlertController(title: "Sorry!", message: "This feature is currently being developed by the Hack AZ Team!", preferredStyle: UIAlertControllerStyle.alert)
            errorAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(errorAlert, animated: true, completion: nil)
//            self.present(alert, animated: true, completion: nil)
//            let dismissAlert = DispatchTime.now() + 0.5
//            DispatchQueue.main.asyncAfter(deadline: dismissAlert) {
//                // Your code with delay
//                self.dismiss(animated: true, completion: nil)
//                // Mentor Hub
//            }
        }else if rowPressed == 5 {
            self.performSegue(withIdentifier: "socialmediaSegue", sender: cellPressed)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "mainCell")
        cell.contentView.backgroundColor = UIColor(red: CGFloat(66)/255.0, green: CGFloat(69)/255.0, blue: CGFloat(120)/255.0, alpha: 1.0)
        cell.textLabel?.textColor = UIColor.white
        if cellContent[indexPath.row].lowercased() == "schedule" {
            cell.textLabel?.text = "\u{1F5D3}" + "\t" + cellContent[indexPath.row]
        }
        if cellContent[indexPath.row].lowercased() == "map" {
            cell.textLabel?.text = "\u{1F5FA}" + "\t" + cellContent[indexPath.row]
        }
        if cellContent[indexPath.row].lowercased() == "events" {
            cell.textLabel?.text = "\u{1F39F}" + "\t" + cellContent[indexPath.row]
        }
        if cellContent[indexPath.row].lowercased() == "live stream" {
            cell.textLabel?.text = "\u{1F4FA}" + "\t" + cellContent[indexPath.row]
        }
        if cellContent[indexPath.row].lowercased() == "mentor hub" {
            cell.textLabel?.text = "\u{1F465}" + "\t" + cellContent[indexPath.row]
        }
        if cellContent[indexPath.row].lowercased() == "social media" {
            cell.textLabel?.text = "\u{1F5E3}" + "\t" + cellContent[indexPath.row]
        }

        cell.textLabel?.font = UIFont(name: "Arial", size:36.0)
        return cell
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getLiveStreamLink()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

