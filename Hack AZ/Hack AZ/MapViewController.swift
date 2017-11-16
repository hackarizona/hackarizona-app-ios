//
//  MapViewController.swift
//  Hack AZ
//
//  Created by Cody Deeran on 10/5/17.
//  Copyright © 2017 Cody Deeran. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let cellContent = ["Floor 1","Floor 2","Floor 3", "Floor 4", "Floor 5"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContent.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
            let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "mainCell")
            cell.contentView.backgroundColor = UIColor(red: CGFloat(75)/255.0, green: CGFloat(79)/255.0, blue: CGFloat(128)/255.0, alpha: 1.0)
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.text = cellContent[indexPath.row]
            cell.textLabel?.font = UIFont(name: "Arial", size:36.0)
            return cell
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let rowPressed = indexPath.row
        let cellPressed = tableView.cellForRow(at: indexPath)
        if rowPressed == 0{
            print("Floor 1 was pressed! Starting segue....")
            performSegue(withIdentifier: "MapSegueFloor1", sender: cellPressed)
        }else if rowPressed == 1 {
            print("Floor 2 was pressed! Starting segue....")
            performSegue(withIdentifier: "MapSegueFloor2", sender: cellPressed)
        }else if rowPressed == 2 {
            print("Floor 3 was pressed! Starting segue....")
            performSegue(withIdentifier: "MapSegueFloor3", sender: cellPressed)
        }else if rowPressed == 3 {
            print("Floor 4 was pressed! Starting segue....")
            performSegue(withIdentifier: "MapSegueFloor4", sender: cellPressed)
        }else if rowPressed == 4 {
            print("Floor 5 was pressed! Starting segue....")
            performSegue(withIdentifier: "MapSegueFloor5", sender: cellPressed)
        }
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
