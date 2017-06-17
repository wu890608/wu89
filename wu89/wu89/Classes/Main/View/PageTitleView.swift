//
//  PageTitleView.swift
//  wu89
//
//  Created by wu on 2017/6/17.
//  Copyright © 2017年 wu. All rights reserved.
//

import UIKit

fileprivate let kScrollLine:CGFloat = 2
class PageTitleView: UIView {

    fileprivate var titles:[String]
    fileprivate lazy var scrollView:UIScrollView = {
        let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        sv.scrollsToTop = false
        sv.bounces = false
        return sv
    }()
    fileprivate lazy var scrollLine : UIView = {
        let sl = UIView()
        sl.backgroundColor = UIColor.orange
        return sl
    }()
    fileprivate lazy var titleLables = [UILabel]()
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PageTitleView{
    fileprivate func setupUI(){
        addSubview(scrollView)
        scrollView.frame = bounds
        setupTitleLables()
        setupBottomMenu()
        
    }
    fileprivate func setupTitleLables(){
        let width =  frame.width / CGFloat(titles.count)
        
        for (index,title) in titles.enumerated() {
            let lable = UILabel()
            lable.text = title
            lable.tag = index
            lable.font = UIFont.systemFont(ofSize: 16)
            lable.textColor = UIColor.darkGray
            lable.textAlignment = .center
            
            titleLables.append(lable)
            lable.frame = CGRect(x:CGFloat(index) * width , y: 0, width:width, height: frame.height - kScrollLine)
            scrollView.addSubview(lable)
        }
    }
    fileprivate  func setupBottomMenu(){
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.lightGray
        let lineHeight:CGFloat = 0.5
        bottomView.frame = CGRect(x: 0, y: frame.height - lineHeight, width: frame.width, height: lineHeight)
        addSubview(bottomView)
        
        scrollView.addSubview(scrollLine)
        let firstLqable = titleLables[0]
        firstLqable.textColor = UIColor.orange
        scrollLine.frame = CGRect(x: firstLqable.frame.origin.x, y: frame.height - kScrollLine, width: firstLqable.frame.width, height: kScrollLine)
    }
}
