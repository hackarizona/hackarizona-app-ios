//
//  SocialMediaViewController.swift
//  Hack AZ
//
//  Created by Cody Deeran on 11/29/17.
//  Copyright © 2017 Cody Deeran. All rights reserved.
//

import UIKit

class SocialMediaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellContent = ["Facebook","Instagram","Twitter","Snapchat"]
    
    func openFacebook() {
        let facebookApp = URL(string: "fb://profile/1530662117173581")
        if UIApplication.shared.canOpenURL(facebookApp!){
            UIApplication.shared.open(facebookApp!, options: [:], completionHandler: nil)
        } else if let facebookURL = URL(string: "https://www.facebook.com/hackarizona") {
            UIApplication.shared.open(facebookURL, options: [:], completionHandler: nil)
        }
    }
    
    func openInstagram() {
        let instagramApp = URL(string: "instagram://user?username=hackarizona")
        if UIApplication.shared.canOpenURL(instagramApp!){
            UIApplication.shared.open(instagramApp!, options: [:], completionHandler: nil)
        } else if let instagramURL = URL(string: "https://www.instagram.com/hackarizona/") {
            UIApplication.shared.open(instagramURL, options: [:], completionHandler: nil)
        }
    }
    
    func openTwitter() {
        let twitterApp = URL(string: "twitter:///user?screen_name=hack_arizona")
        if UIApplication.shared.canOpenURL(twitterApp!){
            UIApplication.shared.open(twitterApp!, options: [:], completionHandler: nil)
        } else if let twitterURL = URL(string: "https://twitter.com/hack_arizona") {
            UIApplication.shared.open(twitterURL, options: [:], completionHandler: nil)
        }
    }

    func openSnapchat() {
        let snapchatApp = URL(string: "snapchat://add/hackarizona")
        if UIApplication.shared.canOpenURL(snapchatApp!) {
            UIApplication.shared.open(snapchatApp!, options: [:], completionHandler: nil)
        } else {
            let errorAlert = UIAlertController(title: "Error!", message: "Could not open Snapchat. Please make sure Snapchat is installed and you are signed in.", preferredStyle: UIAlertControllerStyle.alert)
            errorAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(errorAlert, animated: true, completion: nil)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContent.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let rowPressed = indexPath.row
        if rowPressed == 0{
           self.navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(64)/255.0, green: CGFloat(104)/255.0, blue: CGFloat(173)/255.0, alpha: 1.0)
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
            openFacebook()
        }else if rowPressed == 1 {
            let color = UIColor(red: CGFloat(252)/255.0, green: CGFloat(171)/255.0, blue: CGFloat(94)/255.0, alpha: 1.0)
            self.navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(147)/255.0, green: CGFloat(63)/255.0, blue: CGFloat(163)/255.0, alpha: 1.0)
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: color ]
            self.navigationItem.leftBarButtonItem?.tintColor = color
            openInstagram()
        }else if rowPressed == 2 {
            self.navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(0)/255.0, green: CGFloat(163)/255.0, blue: CGFloat(236)/255.0, alpha: 1.0)
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
            openTwitter()
        }else if rowPressed == 3 {
            self.navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(255)/255.0, green: CGFloat(250)/255.0, blue: CGFloat(85)/255.0, alpha: 1.0)
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
            self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
            openSnapchat()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "mainCell")
        cell.contentView.backgroundColor = UIColor.black
        let text = cellContent[indexPath.row]
        if (text == "Facebook"){
            cell.textLabel?.textColor = UIColor(red: CGFloat(64)/255.0, green: CGFloat(104)/255.0, blue: CGFloat(173)/255.0, alpha: 1.0)
            cell.textLabel?.text = text
            cell.textLabel?.font = UIFont(name: "Arial", size:36.0)
        }else if (text == "Instagram"){
            cell.textLabel?.textColor = UIColor(red: CGFloat(147)/255.0, green: CGFloat(63)/255.0, blue: CGFloat(163)/255.0, alpha: 1.0)
            cell.textLabel?.text = text
            cell.textLabel?.font = UIFont(name: "Arial", size:36.0)
        }else if (text == "Twitter"){
            cell.textLabel?.textColor = UIColor(red: CGFloat(0)/255.0, green: CGFloat(163)/255.0, blue: CGFloat(236)/255.0, alpha: 1.0)
            cell.textLabel?.text = text
            cell.textLabel?.font = UIFont(name: "Arial", size:36.0)
        }else if (text == "Snapchat"){
            cell.textLabel?.textColor = UIColor(red: CGFloat(255)/255.0, green: CGFloat(250)/255.0, blue: CGFloat(85)/255.0, alpha: 1.0)
            cell.textLabel?.text = text
            cell.textLabel?.font = UIFont(name: "Arial", size:36.0)
        }
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(64)/255.0, green: CGFloat(104)/255.0, blue: CGFloat(173)/255.0, alpha: 1.0)
        // Do any additional setup after loading the view.
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
