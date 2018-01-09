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
            cell.textLabel?.font = UIFont(name: "Arial", size:22.0)
        }else{
            cell.contentView.backgroundColor = UIColor.black
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.text = eventtitle[indexPath.row]
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.textLabel?.font = UIFont(name: "Arial", size:22.0)
            cell.detailTextLabel?.numberOfLines = 0
            cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.detailTextLabel?.text = "Time: " + time[indexPath.row] + "\nLocation: " + location[indexPath.row]
            cell.detailTextLabel?.font = UIFont(name: "Arial", size:16.0)
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
