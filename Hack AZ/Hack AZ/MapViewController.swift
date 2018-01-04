//
//  MapVC.swift
//  Hack AZ
//
//  Created by Cody Deeran on 11/28/17.
//  Copyright © 2017 Cody Deeran. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellContent = ["Floor 1","Floor 2","Floor 3", "Floor 4", "Floor 5"]
    let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContent.count
    }
    
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
            self.goToSegue(segue: "FloorSegue1", cell: cellPressed)
        }else if rowPressed == 1 {
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            self.goToSegue(segue: "FloorSegue2", cell: cellPressed)
        }else if rowPressed == 2 {
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            self.goToSegue(segue: "FloorSegue3", cell: cellPressed)
        }else if rowPressed == 3 {
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            self.goToSegue(segue: "FloorSegue4", cell: cellPressed)
        }else if rowPressed == 4 {
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            self.goToSegue(segue: "FloorSegue5", cell: cellPressed)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "mainCell")
        //        cell.contentView.backgroundColor = UIColor(red: CGFloat(75)/255.0, green: CGFloat(79)/255.0, blue: CGFloat(128)/255.0, alpha: 1.0)
        cell.contentView.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor(red: CGFloat(75)/255.0, green: CGFloat(79)/255.0, blue: CGFloat(128)/255.0, alpha: 1.0)
        cell.textLabel?.text = cellContent[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Arial", size:36.0)
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
    
    /*
     MARK: - Navigation
     
     In a storyboard-based application, you will often want to do a little preparation before navigation
     */
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
