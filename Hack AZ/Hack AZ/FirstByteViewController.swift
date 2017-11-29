//
//  FirstByteViewController.swift
//  Hack AZ
//
//  Created by Cody Deeran on 11/29/17.
//  Copyright © 2017 Cody Deeran. All rights reserved.
//

import UIKit

class FirstByteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellContent = ["Friday","Saturday","Sunday"]
    
    private func goToSegue(segue: String!, cell: UITableViewCell?) {
        let dismissAlert = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: dismissAlert) {
            self.dismiss(animated: true, completion: nil)
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
        let alert = UIAlertController(title: "Loading...", message: "", preferredStyle: .alert)
        if rowPressed == 0{
            self.present(alert, animated: true, completion: nil)
            self.goToSegue(segue: "FirstByteFridaySegue", cell: cellPressed)
        }else if rowPressed == 1 {
            self.present(alert, animated: true, completion: nil)
            self.goToSegue(segue: "FirstByteSaturdaySegue", cell: cellPressed)
        }else if rowPressed == 2 {
            self.present(alert, animated: true, completion: nil)
            self.goToSegue(segue: "FirstByteSundaySegue", cell: cellPressed)
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
