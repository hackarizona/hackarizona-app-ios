//
//  ViewController.swift
//  Hack AZ
//
//  Created by Cody Deeran on 10/1/17.
//  Copyright © 2017 Cody Deeran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var sponsorLabel: UILabel!
    let cellContent = ["Schedule","Map","Activities", "Events", "Mentors" ,"Sponsors"]
    let sponsors = ["RAYTHEON","IBM","AMAZON","INTUIT","GOOGLE","MICROSOFT"]
    var sponsorShown = 0;
    var sponsorTimer = Timer()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContent.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let rowPressed = indexPath.row
        let cellPressed = tableView.cellForRow(at: indexPath)
        if rowPressed == 0{
            print("Schedule was pressed! Starting segue....")
            sponsorTimer.invalidate()
            performSegue(withIdentifier: "ScheduleViewController", sender: cellPressed)
        }else if rowPressed == 1 {
            print("Map was pressed! Starting segue....")
            sponsorTimer.invalidate()
            performSegue(withIdentifier: "MapSegue", sender: cellPressed)
        }else if rowPressed == 2 {
            print("row 2 was pressed!")
//            sponsorTimer.invalidate()
        }else if rowPressed == 3 {
            print("row 3 was pressed!")
//            sponsorTimer.invalidate()
        }else if rowPressed == 4 {
            print("row 4 was pressed!")
//            sponsorTimer.invalidate()
        }else if rowPressed == 5 {
            print("row 5 was pressed!")
//            sponsorTimer.invalidate()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "mainCell")
        cell.contentView.backgroundColor = UIColor.white
        cell.textLabel?.textColor = UIColor(red: CGFloat(67)/255.0, green: CGFloat(73)/255.0, blue: CGFloat(116)/255.0, alpha: 1.0)
        cell.textLabel?.text = cellContent[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Arial", size:24.0)
        return cell
        
    }
    
    @objc func changeSponsorLabel() {
        if sponsorShown == sponsors.count {
            sponsorShown = 0;
        }else {
            sponsorLabel.text = sponsors[sponsorShown]
            sponsorShown += 1
        } 
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sponsorLabel.text = sponsors[sponsorShown]
        sponsorShown += 1
        sponsorTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(ViewController.changeSponsorLabel), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

