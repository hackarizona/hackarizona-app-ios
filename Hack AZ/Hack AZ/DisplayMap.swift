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
        scrollView.delegate = self
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 10.0
        if (floor > 0){
            let floorToView = String(floor)
            self.title = "FLOOR \(floorToView)".uppercased()
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
    
    @objc func displayFloorDetails(sender: UIBarButtonItem) {
        var details = ""
        if(floor == 1){
            details = "Hacking\nActivities"
        }else if(floor == 2){
            details = "Hacking\nSponsors\nActivities\nFood"
        }else if(floor == 3 || floor == 4){
            details = "Hacking\nSponsors\nActivities"
        }else {
            details = "Hacking\nSponsors\nActivities\nTech Talks"
        }
        
        let alert = UIAlertController(title: "On This Floor", message: details , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
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
