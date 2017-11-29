//
//  MapVC.swift
//  Hack AZ
//
//  Created by Cody Deeran on 11/28/17.
//  Copyright © 2017 Cody Deeran. All rights reserved.
//

import UIKit

class MapViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    lazy var mapArray: [UIViewController] = {
        return [self.viewControllerInstance(name: "floor1"),self.viewControllerInstance(name: "floor2"),self.viewControllerInstance(name: "floor3"),self.viewControllerInstance(name: "floor4"),self.viewControllerInstance(name: "floor5")]
    }()
    
    private func viewControllerInstance (name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = mapArray.index(of: viewController) else {
            return nil
        }
        
        let prevIndex = vcIndex - 1
        
        guard prevIndex >= 0 else {
            return mapArray.last
        }
        
        guard mapArray.count > prevIndex else {
            return nil
        }
        
        return mapArray[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = mapArray.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = vcIndex + 1
        
        guard nextIndex < mapArray.count else {
            return mapArray.first
        }
        
        guard mapArray.count > nextIndex else {
            return nil
        }
        
        return mapArray[nextIndex]
    }
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return mapArray.count
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstVC = viewControllers?.first, let firstVCIndex = mapArray.index(of: firstVC) else {
            return 0
        }
        
        return firstVCIndex
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource = self
        self.delegate = self
        if let firstVC = mapArray.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
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
