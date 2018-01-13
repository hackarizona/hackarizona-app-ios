//
//  MapVC.swift
//  Hack AZ
//
//  Created by Cody Deeran on 11/28/17.
//  Copyright © 2017 Cody Deeran. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellContent = ["Basement","Main Floor","Floor 3", "Raytheon Floor", "Jacobs Floor"]
    let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContent.count
    }
    
    // Action when cell is pressed
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let rowPressed = indexPath.row
        let cellPressed = tableView.cellForRow(at: indexPath)
        if rowPressed == 0{
            self.performSegue(withIdentifier: "FloorSegue1", sender: cellPressed)
        }else if rowPressed == 1 {
            self.performSegue(withIdentifier: "FloorSegue2", sender: cellPressed)
        }else if rowPressed == 2 {
            self.performSegue(withIdentifier: "FloorSegue3", sender: cellPressed)
        }else if rowPressed == 3 {
            self.performSegue(withIdentifier: "FloorSegue4", sender: self)
        }else if rowPressed == 4 {
            self.performSegue(withIdentifier: "FloorSegue5", sender: self)
        }
    }
    
    // Setup cell design
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "mainCell")
        cell.contentView.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor(red: CGFloat(75)/255.0, green: CGFloat(79)/255.0, blue: CGFloat(128)/255.0, alpha: 1.0)
        cell.textLabel?.text = cellContent[indexPath.row].uppercased()
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.font = UIFont(name: "Arial", size:28.0)
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(66)/255.0, green: CGFloat(69)/255.0, blue: CGFloat(120)/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white ]
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Prepare for segue to next view controller to display map
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FloorSegue1" {
            let tempController = segue.destination as! UINavigationController
            let showMap = tempController.topViewController as! DisplayMap
            showMap.floor = 1
        }else if segue.identifier == "FloorSegue2" {
            let tempController = segue.destination as! UINavigationController
            let showMap = tempController.topViewController as! DisplayMap
            showMap.floor = 2
        }else if segue.identifier == "FloorSegue3" {
            let tempController = segue.destination as! UINavigationController
            let showMap = tempController.topViewController as! DisplayMap
            showMap.floor = 3
        }else if segue.identifier == "FloorSegue4" {
            let tempController = segue.destination as! UINavigationController
            let showMap = tempController.topViewController as! DisplayMap
            showMap.floor = 4
        }else if segue.identifier == "FloorSegue5" {
            let tempController = segue.destination as! UINavigationController
            let showMap = tempController.topViewController as! DisplayMap
            showMap.floor = 5
        }
    }
}
