//
//  TechTalksViewController.swift
//  Hack AZ
//
//  Created by Cody Deeran on 11/5/17.
//  Copyright © 2017 Cody Deeran. All rights reserved.
//

import UIKit
import Alamofire
import Alamofire_Synchronous
import SwiftyJSON

class DisplayTechTalksSchedule: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var activityIndicator = UIActivityIndicatorView.init()
    var talkSponsor = [String]()
    var talkName = [String]()
    var talkTime = [String]()
    var talkLocation = [String]()
    var first_description = [String]()
    var daySelected = ""
    
    // phone screen size
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0
    
    // Screen Size for formatting
    let iPhoneSE_Width: CGFloat = 320
    let iPhoneSE_Height: CGFloat = 568

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return talkSponsor.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Display the tech talks
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "mainCell")
        if(talkSponsor[indexPath.row] == ""){
            cell.contentView.backgroundColor = UIColor.black
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.text = "There is currently no Tech Talks scheduled for this day."
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.textLabel?.font = UIFont(name: "Arial", size:22.0)
        }else{
            cell.contentView.backgroundColor = UIColor.black
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.text = talkName[indexPath.row]
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.detailTextLabel?.numberOfLines = 0
            cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.detailTextLabel?.text = "Sponsor: " + talkSponsor[indexPath.row] + "\nTime: " + talkTime[indexPath.row] + "\nLocation: " + talkLocation[indexPath.row]
            cell.detailTextLabel?.textColor = UIColor(red: CGFloat(149)/255.0, green: CGFloat(127)/255.0, blue: CGFloat(197)/255.0, alpha: 1.0)
            if(screenWidth == iPhoneSE_Width && screenHeight == iPhoneSE_Height){
                cell.textLabel?.font = UIFont(name: "Arial", size:21.0)
                cell.detailTextLabel?.font = UIFont(name: "Arial", size:14.0)
            }else{
                cell.textLabel?.font = UIFont(name: "Arial", size:22.0)
                cell.detailTextLabel?.font = UIFont(name: "Arial", size:15.0)
            }
        }
        
        return cell
    }
    
    // Display the description when cell is pressed
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let rowPressed = indexPath.row
        for id in 0...(self.talkSponsor.count-1) {
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
        screenWidth = self.view.frame.width
        screenHeight = self.view.frame.height
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
