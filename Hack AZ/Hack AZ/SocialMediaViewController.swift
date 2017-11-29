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
        if let facebookApp = URL(string: "fb://profile/1530662117173581"){
            UIApplication.shared.open(facebookApp, options: [:], completionHandler: nil)
        } else if let facebookURL = URL(string: "https://www.facebook.com/hackarizona") {
            UIApplication.shared.open(facebookURL, options: [:], completionHandler: nil)
        }
    }
    
    func openInstagram() {
        if let instagramApp = URL(string: "instagram://user?username=hackarizona"){
            UIApplication.shared.open(instagramApp, options: [:], completionHandler: nil)
        } else if let instagramURL = URL(string: "https://www.instagram.com/hackarizona/") {
            UIApplication.shared.open(instagramURL, options: [:], completionHandler: nil)
        }
    }
    
    func openTwitter() {
        if let twitterApp = URL(string: "twitter:///user?screen_name=hack_arizona"){
            UIApplication.shared.open(twitterApp, options: [:], completionHandler: nil)
        } else if let twitterURL = URL(string: "https://twitter.com/hack_arizona") {
            UIApplication.shared.open(twitterURL, options: [:], completionHandler: nil)
        }
    }

    func openSnapchat() {
        if let snapchatApp = URL(string: "snapchat://add/hackarizona"){
            UIApplication.shared.open(snapchatApp, options: [:], completionHandler: nil)
        } else {
            let errorAlert = UIAlertController(title: "Error!", message: "Could not load Snapchat :(", preferredStyle: UIAlertControllerStyle.alert)
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
            openFacebook()
        }else if rowPressed == 1 {
            openInstagram()
        }else if rowPressed == 2 {
            openTwitter()
        }else if rowPressed == 3 {
            openSnapchat()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "mainCell")
        cell.contentView.backgroundColor = UIColor(red: CGFloat(75)/255.0, green: CGFloat(79)/255.0, blue: CGFloat(128)/255.0, alpha: 1.0)
        cell.textLabel?.textColor = UIColor.white
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
