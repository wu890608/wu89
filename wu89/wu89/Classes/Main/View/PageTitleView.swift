//
//  PageTitleView.swift
//  wu89
//
//  Created by wu on 2017/6/17.
//  Copyright © 2017年 wu. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate:class {
    func pageView(titleView:PageTitleView,selectedIndex index: Int)
}

fileprivate let kScrollLine:CGFloat = 2
fileprivate let kNormalColor :(CGFloat,CGFloat,CGFloat) = (85,85,85)
fileprivate let kSelectColor :(CGFloat,CGFloat,CGFloat) = (255,128,0)
class PageTitleView: UIView {

    weak var delegate :PageTitleViewDelegate?
    fileprivate var titles:[String]
    fileprivate var currentIndex = 0
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
            
            lable.isUserInteractionEnabled = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(titleLableClick(tap:)))
            lable.addGestureRecognizer(tap)
            
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
extension PageTitleView{
    @objc fileprivate func titleLableClick(tap:UITapGestureRecognizer){
        guard let currentLable = tap.view as? UILabel else { return }
        let oldLable = titleLables[currentIndex]
        currentIndex = currentLable.tag
        currentLable.textColor = UIColor.orange
        oldLable.textColor = UIColor.darkGray
        
        let scrollLinePosition = CGFloat(currentLable.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.2) { 
            self.scrollLine.frame.origin.x = scrollLinePosition
        }
        delegate?.pageView(titleView: self, selectedIndex: currentIndex)

    }
}
extension PageTitleView{
    func setTitle(progress:CGFloat,sourceIndex:Int,targetIndex:Int) {
        let sourceLable = titleLables[sourceIndex]
        let targetLable = titleLables[targetIndex]
        
        let moveToX = targetLable.frame.origin.x - sourceLable.frame.origin.x
        let moveX = moveToX * progress
        scrollLine.frame.origin.x = sourceLable.frame.origin.x + moveX
        
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        
        sourceLable.textColor = UIColor(red: (kSelectColor.0 - colorDelta.0 * progress) / 255.0, green: (kSelectColor.1 - colorDelta.1 * progress) / 255.0, blue: (kSelectColor.2 - colorDelta.2 * progress) / 255.0, alpha: 1)
        targetLable.textColor = UIColor(red: (kNormalColor.0 + colorDelta.0 * progress) / 255.0, green: (kNormalColor.1 + colorDelta.1 * progress) / 255.0, blue: (kNormalColor.2 + colorDelta.2 * progress) / 255.0, alpha: 1)
        currentIndex = targetIndex
    }
}
