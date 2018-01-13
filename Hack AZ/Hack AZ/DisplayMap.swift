//
//  DisplayMap.swift
//  Hack AZ
//
//  Created by Cody Deeran on 12/12/17.
//  Copyright © 2017 Cody Deeran. All rights reserved.
//

import UIKit

class DisplayMap: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    var floor = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(red: CGFloat(66)/255.0, green: CGFloat(69)/255.0, blue: CGFloat(120)/255.0, alpha: 1.0)]
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: CGFloat(66)/255.0, green: CGFloat(69)/255.0, blue: CGFloat(120)/255.0, alpha: 1.0)
        scrollView.delegate = self
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 10.0
        
        // load map by floor
        if (floor == 1){
            let floorToView = String(floor)
            self.title = "BASEMENT".uppercased()
            let floor_image:UIImage! = UIImage(named: "floor\(floorToView).png")
            self.imageView.image = floor_image
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Details", style: .plain, target: self, action: #selector(displayFloorDetails))
            
        }else if (floor == 2){
            let floorToView = String(floor)
            self.title = "MAIN FLOOR".uppercased()
            let floor_image:UIImage! = UIImage(named: "floor\(floorToView).png")

            self.imageView.image = floor_image
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Details", style: .plain, target: self, action: #selector(displayFloorDetails))
            
        }else if (floor == 3){
            let floorToView = String(floor)
            self.title = "FLOOR 3".uppercased()
            let floor_image:UIImage! = UIImage(named: "floor\(floorToView).png")

            self.imageView.image = floor_image
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Details", style: .plain, target: self, action: #selector(displayFloorDetails))
            
        }else if (floor == 4){
            let floorToView = String(floor)
            self.title = "RAYTHEON FLOOR".uppercased()
            let floor_image:UIImage! = UIImage(named: "floor\(floorToView).png")
            self.imageView.image = floor_image
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Details", style: .plain, target: self, action: #selector(displayFloorDetails))
            
        }else if (floor == 5){
            let floorToView = String(floor)
            self.title = "JACOBS FLOOR".uppercased()
            let floor_image:UIImage! = UIImage(named: "floor\(floorToView).png")
            self.imageView.image = floor_image
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Details", style: .plain, target: self, action: #selector(displayFloorDetails))
            
        }else{
            let alert = UIAlertController(title: "Error!", message: "Sorry, there was an error while trying to display the floor" , preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    // Alert for when details is pressed
    @objc func displayFloorDetails(sender: UIBarButtonItem) {
        var details = ""
        if(floor == 1){
            details = "Yellow: MLH Hardware Lab\nGreen: Elevators\nOrange: Restrooms\nBrown: Stairs"
        }else if(floor == 2){
            details = "Red: iSpace\nYellow: 200S Activity Room\nBlue: Help Desk/Volunteers\nGreen: Elevators\nOrange: Restrooms\nBrown: Stairs"
        }else if(floor == 3){
            details = "Purple: firstByte Workshops\nGreen: Elevators\nOrange: Restrooms\nBrown: Stairs"
        }else if(floor == 4){
            details = "Green: Elevators\nOrange: Restrooms\nBrown: Stairs"
        }else if(floor == 5) {
            details = "Yellow: Tech Talks\nGreen: Elevators\nOrange: Restrooms\nBrown: Stairs"
        }
        
        let alert = UIAlertController(title: "Key", message: nil , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        
        // Code to align alert message body left.
        // Code provided by: https://chauyanw.wordpress.com/2017/01/29/uialertcontroller-text-alignment/
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        
        let messageText = NSMutableAttributedString(
            string: details,
            attributes: [
                NSAttributedStringKey.paragraphStyle: paragraphStyle,
                NSAttributedStringKey.font : UIFont.preferredFont(forTextStyle: .body),
                NSAttributedStringKey.foregroundColor : UIColor.black
            ]
        )
        
        alert.setValue(messageText, forKey: "attributedMessage")
        self.present(alert, animated: true, completion: nil)
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
