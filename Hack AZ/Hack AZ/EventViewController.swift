//
//  SponsorsViewController.swift
//  Hack AZ
//
//  Created by Cody Deeran on 11/10/17.
//  Copyright © 2017 Cody Deeran. All rights reserved.
//

import UIKit

class EventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellContent = ["\u{1F468}\u{200D}\u{1F4BB}  Tech Talks", "\u{1F3C3}\u{200D}\u{2642}\u{FE0F}  Activites", "\u{1F469}\u{200D}\u{1F3EB}  First Byte"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContent.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let rowPressed = indexPath.row
        let cellPressed = tableView.cellForRow(at: indexPath)
        
        if rowPressed == 0{
            self.performSegue(withIdentifier: "TechTalksSegue", sender: cellPressed)
        }else if rowPressed == 1 {
            self.performSegue(withIdentifier: "ActivitiesSegue", sender: cellPressed)
        }else if rowPressed == 2 {
            self.performSegue(withIdentifier: "FirstByteSegue", sender: cellPressed)
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
