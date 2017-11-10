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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let rowPressed = indexPath.row
        let cellPressed = tableView.cellForRow(at: indexPath)
        let alert = UIAlertController(title: "Loading...", message: "", preferredStyle: .alert)
        if rowPressed == 0{
            print("Friday was pressed! Starting segue....")
            self.present(alert, animated: true, completion: nil)
            let dismissAlert = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: dismissAlert) {
                // Your code with delay
                self.dismiss(animated: true, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    // Your code with delay
                    self.performSegue(withIdentifier: "viewFridayScheduleSegue", sender: cellPressed)
                }
            }
        }else if rowPressed == 1 {
            print("Saturday was pressed! Starting segue....")
            self.present(alert, animated: true, completion: nil)
            let dismissAlert = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: dismissAlert) {
                // Your code with delay
                self.dismiss(animated: true, completion: nil)
                let deploySeg = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: deploySeg) {
                    // Your code with delay
                    self.performSegue(withIdentifier: "viewSaturdayScheduleSegue", sender: cellPressed)
                }
            }
        }else if rowPressed == 2 {
            print("Saturday was pressed! Starting segue....")
            self.present(alert, animated: true, completion: nil)
            let dismissAlert = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: dismissAlert) {
                // Your code with delay
                self.dismiss(animated: true, completion: nil)
                let deploySeg = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: deploySeg) {
                    // Your code with delay
                    self.performSegue(withIdentifier: "viewSundayScheduleSegue", sender: cellPressed)
                }
            }
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
