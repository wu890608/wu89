//
//  HomeViewController.swift
//  wu89
//
//  Created by wu on 2017/6/16.
//  Copyright © 2017年 wu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    fileprivate lazy var pageTitleView:PageTitleView = {[weak self] in
        let frame = CGRect(x: 0, y: 64, width: sWidth, height: 44)
        let tv = PageTitleView(frame: frame, titles: ["推荐","游戏","娱乐","趣玩"])
        tv.delegate = self
        return tv
    }()
    fileprivate lazy var pageContentView:PageContentView = {[weak self] in
        let frame = CGRect(x: 0, y: 108, width: sWidth, height: sHeight - 108)
        
        var vcs = [UIViewController]()
        vcs.append(RecommendViewController())
        for i in 0..<3{
            let vc = UIViewController()
            vc.view.backgroundColor = [UIColor.green,UIColor.red,UIColor.gray,UIColor.black][i]
            vcs.append(vc)
        }
        
        let pcv = PageContentView(frame: frame, childVcs: vcs, parentVC: self)
        pcv.delegate = self
        return pcv
     }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}
// MARK: - 设置UI界面
extension HomeViewController{
    fileprivate func setupUI(){
        automaticallyAdjustsScrollViewInsets = false
        setupNavigationBar()
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
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
extension HomeViewController:PageTitleViewDelegate{
    func pageView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}
extension HomeViewController:pageContentViewDelegate{
    func pageContentView(pageCOntentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitle(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
