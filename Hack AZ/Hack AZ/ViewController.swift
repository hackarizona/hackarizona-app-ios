//
//  ViewController.swift
//  Hack AZ
//
//  Created by Cody Deeran on 10/1/17.
//  Copyright © 2017 Cody Deeran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let url = URL(string: "http://hackarizona.org/livestream.json")!
    var liveStreamUrl = ""
    
    func getLiveStreamLink() -> Void {
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            if error != nil {
                print(error!)
            }else{
                if let urlContent = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options:JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                        if let jsonData = (jsonResult!["livestream"] as? NSArray) {
                            self.liveStreamUrl = (jsonData[0] as? NSDictionary)?["link"] as! String
                        }
                    } catch {
                        print("JSON Processing Failed!")
                    }
                }
            }
        }
        task.resume()
    }
    @IBAction func liveStream(_ sender: UIButton) {
        let alert = UIAlertController(title: "Loading...", message: "", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        let dismissAlert = DispatchTime.now() + 0.7
        DispatchQueue.main.asyncAfter(deadline: dismissAlert) {
            self.dismiss(animated: true, completion: nil)
            if let stream = URL(string: self.liveStreamUrl ) {
                UIApplication.shared.open(stream, options: [:], completionHandler: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getLiveStreamLink()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

