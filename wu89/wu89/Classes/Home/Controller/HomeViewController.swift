//
//  HomeViewController.swift
//  wu89
//
//  Created by wu on 2017/6/16.
//  Copyright © 2017年 wu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}
// MARK: - 设置UI界面
extension HomeViewController{
    fileprivate func setupUI(){
        setupNavigationBar()
        
    }
    fileprivate func setupNavigationBar(){
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "logo"), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        let historyItem = UIBarButtonItem.createItem(image: #imageLiteral(resourceName: "image_my_history"), heightImage: #imageLiteral(resourceName: "Image_my_history_click"))
        let searchItem = UIBarButtonItem.createItem(image: #imageLiteral(resourceName: "btn_search"), heightImage: #imageLiteral(resourceName: "btn_search_clicked"))
        let qrcodeItem = UIBarButtonItem.createItem(image: #imageLiteral(resourceName: "Image_scan"), heightImage: #imageLiteral(resourceName: "Image_scan_click"))
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
    }
}
