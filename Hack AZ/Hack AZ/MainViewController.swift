//
//  MainViewController.swift
//  Hack AZ
//
//  Created by Cooper Kunz on 12/4/17.
//  Copyright © 2017 CooperKunz. All rights reserved.
//
//  Modified by Cody Deeran on 12/22/17
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    //A basic way to make your sections dynamic would be to pull an array.
    let sections = ["Schedule", "Events", "Maps", "Mentor Hub", "Live Stream", "Social Media"]
    let imageSection = ["schedule_icon.jpeg","events_icon.jpeg","map_icon.jpeg","mentor_hub_icon.jpeg","live_stream_icon.jpeg","social_media_icon.jpeg"]
    let url = URL(string: "http://hackarizona.org/livestream.json")!
    let url2 = URL(string: "http://hackarizona.org/mentorhub.json")!
    var liveStreamUrl = ""
    var mentorHubUrl = ""
    
    // phone screen size
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0
    
    // Got the screen sizes from the simulators
    // This helps with the layout
    let iPhoneSE_Width: CGFloat = 320
    let iPhoneSE_Height: CGFloat = 568
    let iPhoneStandard_Width: CGFloat = 375
    let iPhoneStandard_Height: CGFloat = 667
    let iPhonePlus_Width: CGFloat = 414
    let iPhonePlus_Height: CGFloat = 736
    let iPhoneX_Width: CGFloat = 375
    let iPhoneX_Height: CGFloat = 812
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HACK ARIZONA"
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(red: CGFloat(183)/255.0, green: CGFloat(122)/255.0, blue: CGFloat(254)/255.0, alpha: 1.0)]
        
        // create the flowlayout
        let flowLayout = UICollectionViewFlowLayout()
        
        //One way to get screen dimensions
        screenWidth = self.view.frame.width
        screenHeight = self.view.frame.height
        
        if(screenWidth == iPhoneX_Width && screenHeight == iPhoneX_Height){
            flowLayout.minimumLineSpacing = 50.0
            let collectionView = UICollectionView(frame:  CGRect(x: 0, y: self.screenHeight * 0.25, width: self.screenWidth, height: screenHeight), collectionViewLayout: flowLayout)
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.backgroundColor = UIColor.clear
            collectionView.contentSize = CGSize(width: 2, height: 6)
            self.view.addSubview(collectionView)
        }else if(screenWidth == iPhonePlus_Width && screenHeight == iPhonePlus_Height){
            flowLayout.minimumLineSpacing = 25.0
            let collectionView = UICollectionView(frame:  CGRect(x: 0, y: self.screenHeight * 0.25, width: self.screenWidth, height: screenHeight), collectionViewLayout: flowLayout)
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.backgroundColor = UIColor.clear
            collectionView.contentSize = CGSize(width: 2, height: 6)
            self.view.addSubview(collectionView)
        }else if(screenWidth == iPhoneSE_Width && screenHeight == iPhoneSE_Height){
            flowLayout.minimumLineSpacing = 50.0
            let collectionView = UICollectionView(frame:  CGRect(x: 0, y: self.screenHeight * 0.32, width: self.screenWidth, height: screenHeight), collectionViewLayout: flowLayout)
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.backgroundColor = UIColor.clear
            collectionView.contentSize = CGSize(width: 2, height: 6)
            self.view.addSubview(collectionView)
        }else{
            flowLayout.minimumLineSpacing = 50.0
            let collectionView = UICollectionView(frame:  CGRect(x: 0, y: self.screenHeight * 0.3, width: self.screenWidth, height: screenHeight), collectionViewLayout: flowLayout)
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.backgroundColor = UIColor.clear
            collectionView.contentSize = CGSize(width: 2, height: 6)
            self.view.addSubview(collectionView)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getLiveStreamLink()
        getMentorHubLink()
    }
    
    //Required collectionView functions
    
    //Cell count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return sections.count
    }
    
    //Cell customization
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath as IndexPath)
        let cellHeight = cell.frame.height
        let cellWidth = cell.frame.width
        
        let imageview:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cellWidth, height: cellHeight))
        let image:UIImage = UIImage(named: imageSection[indexPath.item])!
        imageview.image = image
        cell.contentView.addSubview(imageview)
        
        if(screenWidth == iPhoneSE_Width && screenHeight == iPhoneSE_Height){
            let cellTitleLabel = UILabel(frame: CGRect(x: 0, y: 60, width: cellWidth, height: cellHeight))
            cellTitleLabel.textAlignment = .center
            cellTitleLabel.text = sections[indexPath.item]
            cellTitleLabel.adjustsFontSizeToFitWidth = true
            cellTitleLabel.textColor = UIColor(red: CGFloat(183)/255.0, green: CGFloat(122)/255.0, blue: CGFloat(254)/255.0, alpha: 1.0)
            cell.contentView.addSubview(cellTitleLabel)
        }else{
            let cellTitleLabel = UILabel(frame: CGRect(x: 0, y: 75, width: cellWidth, height: cellHeight))
            cellTitleLabel.textAlignment = .center
            cellTitleLabel.text = sections[indexPath.item]
            cellTitleLabel.adjustsFontSizeToFitWidth = true
            cellTitleLabel.textColor = UIColor(red: CGFloat(183)/255.0, green: CGFloat(122)/255.0, blue: CGFloat(254)/255.0, alpha: 1.0)
            cell.contentView.addSubview(cellTitleLabel)
        }
        return cell
    }
    
    //Cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if(screenWidth == iPhoneSE_Width && screenHeight == iPhoneSE_Height){
            return CGSize(width: screenWidth / 2 - 50, height: 75 )
        }else if (screenWidth == iPhonePlus_Width && screenHeight == iPhonePlus_Height){
            return CGSize(width: screenWidth / 2 - 30, height: 145 )
        }else if (screenWidth == iPhoneX_Width && screenHeight == iPhoneX_Height){
            return CGSize(width: screenWidth / 2 - 30, height: 130 )
        }else{
            return CGSize(width: screenWidth / 2 - 30, height: 100 )
        }
        
    }
    
    //Cell insets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        if(screenWidth == iPhoneSE_Width && screenHeight == iPhoneSE_Height){
            return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        }else{
            return UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        }
        
    }
    
    //Cell selections
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //What happens when you select a cell
        let cellSelected = sections[indexPath.item].lowercased()
        let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        self.view.addSubview(activityIndicator)
        if(cellSelected == "schedule"){
            let controller = storyboard?.instantiateViewController(withIdentifier: "ScheduleController")
            self.present(controller!, animated: true)
        }else if(cellSelected == "events"){
            let controller = storyboard?.instantiateViewController(withIdentifier: "EventsController")
            self.present(controller!, animated: true)
        }else if(cellSelected == "maps"){
            let controller = storyboard?.instantiateViewController(withIdentifier: "MapController")
            self.present(controller!, animated: true)
        }else if(cellSelected == "live stream"){
            getLiveStreamLink()
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            let dismissAlert = DispatchTime.now() +  1.0
            DispatchQueue.main.asyncAfter(deadline: dismissAlert) {
                activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                if let streamUrl = URL(string: self.liveStreamUrl){
                    UIApplication.shared.open(streamUrl, options: [:], completionHandler: nil)
                }
            }
        }else if(cellSelected == "mentor hub"){
            getMentorHubLink()
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            let dismissAlert = DispatchTime.now() + 1.0
            DispatchQueue.main.asyncAfter(deadline: dismissAlert) {
                activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                if let streamUrl = URL(string: self.mentorHubUrl){
                    UIApplication.shared.open(streamUrl, options: [:], completionHandler: nil)
                }
            }
        }else if(cellSelected == "social media"){
            let controller = storyboard?.instantiateViewController(withIdentifier: "SocialMediaController")
            self.present(controller!, animated: true)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) {
                cell.contentView.transform = .init(scaleX: 0.95, y: 0.95)
                cell.contentView.backgroundColor = UIColor(red: CGFloat(183)/255.0, green: CGFloat(122)/255.0, blue: CGFloat(254)/255.0, alpha: 1.0)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) {
                cell.contentView.transform = .identity
                cell.contentView.backgroundColor = .clear
            }
        }
    }
    
    func getLiveStreamLink() -> Void {
        // Disable caching
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 60.0)
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
            if error != nil {
                print(error!)
            }else{
                if let urlContent = data {
                    do {
                        var jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: []) as? [String: Any]
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
    
    func getMentorHubLink() -> Void {
        // Disable caching
        let request = URLRequest(url: url2, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 60.0)
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
            if error != nil {
                print(error!)
            }else{
                if let urlContent = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options:JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                        if let jsonData = (jsonResult!["mentorhub"] as? NSArray) {
                            self.mentorHubUrl = (jsonData[0] as? NSDictionary)?["link"] as! String
                        }
                    } catch {
                        print("JSON Processing Failed!")
                    }
                }
            }
        }
        task.resume()
    }
    
}
