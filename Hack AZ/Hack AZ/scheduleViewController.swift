//
//  ScheduleViewController.swift
//  Hack AZ
//
//  Created by Cody Deeran on 10/4/17.
//  Copyright © 2017 Cody Deeran. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let cellContent = ["Friday","Saturday","Sunday"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContent.count
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let rowPressed = indexPath.row
//        let cellPressed = tableView.cellForRow(at: indexPath)
//        if rowPressed == 0{
//            print("Schedule was pressed! Starting segue....")
//            performSegue(withIdentifier: "ScheduleViewController", sender: cellPressed)
//        }else if rowPressed == 1 {
//            print("row 1 was pressed!")
//        }else if rowPressed == 2 {
//            print("row 2 was pressed!")
//        }else if rowPressed == 3 {
//            print("row 3 was pressed!")
//        }else if rowPressed == 4 {
//            print("row 4 was pressed!")
//        }else if rowPressed == 5 {
//            print("row 5 was pressed!")
//        }
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "mainCell")
        cell.contentView.backgroundColor = UIColor.white
        cell.textLabel?.textColor = UIColor(red: CGFloat(67)/255.0, green: CGFloat(73)/255.0, blue: CGFloat(116)/255.0, alpha: 1.0)
        cell.textLabel?.text = cellContent[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Arial", size:24.0)
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
