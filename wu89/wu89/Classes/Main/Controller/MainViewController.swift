//
//  MainViewController.swift
//  wu89
//
//  Created by wu on 2017/6/16.
//  Copyright © 2017年 wu. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVc(storyName: "Home")
        addChildVc(storyName: "Live")
        addChildVc(storyName: "Follow")
        addChildVc(storyName: "Mine")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    fileprivate func addChildVc(storyName:String){
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVc)
    }
}
