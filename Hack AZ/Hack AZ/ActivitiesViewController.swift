//
//  TechTalksVC.swift
//  Hack AZ
//
//  Created by Cody Deeran on 11/9/17.
//  Copyright © 2017 Cody Deeran. All rights reserved.
//

import UIKit

class ActivitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellContent = ["Friday","Saturday","Sunday"]
    let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    private func goToSegue(segue: String!, cell: UITableViewCell?) {
        let dismissAlert = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: dismissAlert) {
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.performSegue(withIdentifier: segue, sender: cell)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContent.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let rowPressed = indexPath.row
        let cellPressed = tableView.cellForRow(at: indexPath)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        self.view.addSubview(activityIndicator)
        if rowPressed == 0{
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            self.goToSegue(segue: "ActivitiesFridaySegue", cell: cellPressed)
        }else if rowPressed == 1 {
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            self.goToSegue(segue: "ActivitiesSaturdaySegue", cell: cellPressed)
        }else if rowPressed == 2 {
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            self.goToSegue(segue: "ActivitiesSundaySegue", cell: cellPressed)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "mainCell")
        cell.contentView.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor(red: CGFloat(110)/255.0, green: CGFloat(115)/255.0, blue: CGFloat(180)/255.0, alpha: 1.0)
        cell.textLabel?.text = cellContent[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Arial", size:36.0)
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ActivitiesFridaySegue" {
            let tempController = segue.destination as! UINavigationController
            let masterScheduleViewController = tempController.topViewController as! DisplayActivitiesSchedule
            masterScheduleViewController.daySelected = "friday"
        }else if segue.identifier == "ActivitiesSaturdaySegue" {
            let tempController = segue.destination as! UINavigationController
            let masterScheduleViewController = tempController.topViewController as! DisplayActivitiesSchedule
            masterScheduleViewController.daySelected = "saturday"
        }else if segue.identifier == "ActivitiesSundaySegue" {
            let tempController = segue.destination as! UINavigationController
            let masterScheduleViewController = tempController.topViewController as! DisplayActivitiesSchedule
            masterScheduleViewController.daySelected = "sunday"
        }
     }
 
    
}


