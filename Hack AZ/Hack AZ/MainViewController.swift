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
    let url2 = URL(string: "http://hackarizona.org/mentorhub.json")!
    var liveStreamUrl = ""
    var mentorHubUrl = ""

    func getLiveStreamLink() -> Void {
        // Disable caching
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 60.0)
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
            if error != nil {
                print(error!)
            }else{
                if let urlContent = data {
                    do {
                        var jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: []) as? [String: Any]
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
    
    func getMentorHubLink() -> Void {
        // Disable caching
        let request = URLRequest(url: url2, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 60.0)
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
            if error != nil {
                print(error!)
            }else{
                if let urlContent = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options:JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                        if let jsonData = (jsonResult!["mentorhub"] as? NSArray) {
                            self.mentorHubUrl = (jsonData[0] as? NSDictionary)?["link"] as! String
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
        let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        self.view.addSubview(activityIndicator)
        if rowPressed == 0{
            self.performSegue(withIdentifier: "scheduleSegue", sender: cellPressed)
        }else if rowPressed == 1 {
            self.performSegue(withIdentifier: "eventsSegue", sender: cellPressed)
        }else if rowPressed == 2 {
            self.performSegue(withIdentifier: "mapSegue", sender: cellPressed)
        }else if rowPressed == 3 {
            getLiveStreamLink()
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            let dismissAlert = DispatchTime.now() +  1.0
            DispatchQueue.main.asyncAfter(deadline: dismissAlert) {
                activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                if let streamUrl = URL(string: self.liveStreamUrl){
                    UIApplication.shared.open(streamUrl, options: [:], completionHandler: nil)
                }
            }
        }else if rowPressed == 4 {
            getMentorHubLink()
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            let dismissAlert = DispatchTime.now() + 1.0
            DispatchQueue.main.asyncAfter(deadline: dismissAlert) {
                activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                if let streamUrl = URL(string: self.mentorHubUrl){
                    UIApplication.shared.open(streamUrl, options: [:], completionHandler: nil)
                }
            }
        }else if rowPressed == 5 {
            self.performSegue(withIdentifier: "socialmediaSegue", sender: cellPressed)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "mainCell")
//        cell.contentView.backgroundColor = UIColor(red: CGFloat(65)/255.0, green: CGFloat(72)/255.0, blue: CGFloat(116)/255.0, alpha: 1.0)
        cell.contentView.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor(red: CGFloat(183)/255.0, green: CGFloat(122)/255.0, blue: CGFloat(254)/255.0, alpha: 1.0)

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

        cell.textLabel?.font = UIFont(name: "Arial", size:30.0)
        return cell
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(183)/255.0, green: CGFloat(122)/255.0, blue: CGFloat(254)/255.0, alpha: 1.0)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getLiveStreamLink()
        getMentorHubLink()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

