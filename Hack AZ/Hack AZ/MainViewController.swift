//
//  MainViewController.swift
//  Hack AZ
//
//  Created by Cooper Kunz on 10/1/17.
//  Copyright © 2017 CodyDeeran. All rights reserved.
//
//  Added CollectionView components by CooperKunz on 12/22/17
//

import UIKit
import Alamofire
import Alamofire_Synchronous
import SwiftyJSON

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    //A basic way to make your sections dynamic would be to pull an array.
    let sections = ["Schedule", "Events", "Maps", "Mentor Hub", "Live Stream", "Communication"]
    let imageSection = ["g_schedule_icon.jpeg","g_events_icon.jpeg","g_maps_icon.jpeg","g_mentor_hub_icon.jpeg","g_live_stream_icon.jpeg","g_ios_communication_icon.jpeg"]
    let url = URL(string: "http://hackarizona.org/livestream.json")!
    let url2 = URL(string: "http://hackarizona.org/mentorhub.json")!
    var liveStreamUrl = ""
    var mentorHubUrl = ""
    
    // variable to set it network times out
    var timedOut = false
    
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
    let iPad_Width: CGFloat = 320
    let iPad_Height: CGFloat = 480
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HACK ARIZONA"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(183)/255.0, green: CGFloat(122)/255.0, blue: CGFloat(254)/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        // create the flowlayout
        let flowLayout = UICollectionViewFlowLayout()
        
        //One way to get screen dimensions
        screenWidth = self.view.frame.width
        screenHeight = self.view.frame.height
        
        // Create the size of the CollectionView based upon iPhone Screen size
        // Alot of redundant code, definitely can be refactored - Cody
        if(screenWidth == iPhoneX_Width && screenHeight == iPhoneX_Height){
            flowLayout.minimumLineSpacing = 50.0
            let collectionView = UICollectionView(frame:  CGRect(x: 0, y: self.screenHeight * 0.28, width: self.screenWidth, height: screenHeight), collectionViewLayout: flowLayout)
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
        }else if(screenWidth == iPad_Width && screenHeight == iPad_Height){
            flowLayout.minimumLineSpacing = 40.0
            let collectionView = UICollectionView(frame:  CGRect(x: 0, y: self.screenHeight * 0.37, width: self.screenWidth, height: screenHeight), collectionViewLayout: flowLayout)
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
        
        // Adjust the button titles based upon iPhone screen
        if(screenWidth == iPhoneSE_Width && screenHeight == iPhoneSE_Height){
            let cellTitleLabel = UILabel(frame: CGRect(x: 0, y: 60, width: cellWidth, height: cellHeight))
            cellTitleLabel.textAlignment = .center
            cellTitleLabel.text = sections[indexPath.item]
            cellTitleLabel.adjustsFontSizeToFitWidth = true
            cellTitleLabel.textColor = UIColor.white
            cell.contentView.addSubview(cellTitleLabel)
        }else if(screenWidth == iPad_Width && screenHeight == iPad_Height){
            let cellTitleLabel = UILabel(frame: CGRect(x: 0, y: 50, width: cellWidth, height: cellHeight))
            cellTitleLabel.textAlignment = .center
            cellTitleLabel.text = sections[indexPath.item]
            cellTitleLabel.adjustsFontSizeToFitWidth = true
            cellTitleLabel.textColor = UIColor.white
            cell.contentView.addSubview(cellTitleLabel)
        }else{
            let cellTitleLabel = UILabel(frame: CGRect(x: 0, y: 75, width: cellWidth, height: cellHeight))
            cellTitleLabel.textAlignment = .center
            cellTitleLabel.text = sections[indexPath.item]
            cellTitleLabel.adjustsFontSizeToFitWidth = true
            cellTitleLabel.textColor = UIColor.white
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
        }else if(screenWidth == iPad_Width && screenHeight == iPad_Height){
            return CGSize(width: screenWidth / 2 - 65, height: 60 )
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
        
        // Create the alert for if there is a network error
        let alert = UIAlertController(title: "Error", message: "Network request timed out. Please try again" , preferredStyle: .alert)
        
        // Actions for when user selects a cell
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
            if !timedOut, let streamUrl = URL(string: self.liveStreamUrl){
                UIApplication.shared.open(streamUrl, options: [:], completionHandler: nil)
            }else {
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                timedOut = false
            }
        }else if(cellSelected == "mentor hub"){
            getMentorHubLink()
            if !timedOut, let streamUrl = URL(string: self.mentorHubUrl){
                UIApplication.shared.open(streamUrl, options: [:], completionHandler: nil)
            }else {
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                timedOut = false
            }
        }else if(cellSelected == "communication"){
            let controller = storyboard?.instantiateViewController(withIdentifier: "CommunicationController")
            self.present(controller!, animated: true)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) {
                cell.contentView.transform = .init(scaleX: 0.0, y: 0.5)
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
    
    // Get the livestream link from the json files
   func getLiveStreamLink() -> Void{
        // Make request with Alamofire
        let response = Alamofire.request(URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 15)).validate().responseJSON()
        switch response.result {
            // SwiftyJSON makes it very easy to get data from json files
            case .success(let value):
                let json = JSON(value)
                if let link = json["livestream"][0]["link"].string {
                    self.liveStreamUrl = link
                }
                break
            case .failure(let error):
                print(error)
                if error._code == NSURLErrorTimedOut || error._code == NSURLErrorNotConnectedToInternet {
                    self.timedOut = true
                }
                break
        }
    }
    
    // Get the Mentor Hub link from the json files
    func getMentorHubLink() -> Void {
        // Make request with Alamofire
        let response = Alamofire.request(URLRequest(url: url2, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 15)).validate().responseJSON()
        switch response.result {
            // SwiftyJSON makes it very easy to get data from json files
            case .success(let value):
                let json = JSON(value)
                if let link = json["mentorhub"][0]["link"].string {
                    self.mentorHubUrl = link
                }
                break
            case .failure(let error):
                print(error)
                if error._code == NSURLErrorTimedOut || error._code == NSURLErrorNotConnectedToInternet {
                    self.timedOut = true
                }
                break
            }
    }
    
}
