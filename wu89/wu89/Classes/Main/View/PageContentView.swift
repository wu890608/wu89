//
//  PageContentView.swift
//  wu89
//
//  Created by wu on 2017/6/17.
//  Copyright © 2017年 wu. All rights reserved.
//

import UIKit
protocol pageContentViewDelegate:class {
    func pageContentView(pageCOntentView:PageContentView,progress:CGFloat,sourceIndex:Int,targetIndex:Int)
}

class PageContentView: UIView {
    weak var delegate:pageContentViewDelegate?

    fileprivate var childVcs:[UIViewController]
    fileprivate weak var parentVc :UIViewController?
    fileprivate lazy var collectionView :UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.bounces = false
        
        cv.dataSource = self
        cv.delegate = self
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    init(frame: CGRect,childVcs:[UIViewController],parentVC:UIViewController?) {
        self.childVcs = childVcs
        self.parentVc = parentVC
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate var starOffsetX:CGFloat = 0
    fileprivate var isForbidScroll = false

}
extension PageContentView{
    fileprivate func setupUI(){
        for vc in childVcs {
            parentVc?.addChildViewController(vc)
        }
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}
extension PageContentView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        for v in cell.contentView.subviews {
            v.removeFromSuperview()
        }
        let childv = childVcs[indexPath.row]
        childv.view.frame = cell.bounds
        cell.contentView.addSubview(childv.view)
        return cell
    }
}
extension PageContentView:UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScroll = false
        starOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbidScroll{
            return
        }
        
        var progress:CGFloat = 0
        var sourceIndx = 0
        var tagetIndx = 0
        
        let currectOffset = scrollView.contentOffset.x
        if currectOffset > starOffsetX {
            progress = currectOffset / scrollView.bounds.width - floor(currectOffset / scrollView.bounds.width)
            sourceIndx = Int(currectOffset / scrollView.bounds.width)
            tagetIndx = sourceIndx + 1
            if tagetIndx >= childVcs.count {
                tagetIndx -= 1
            }
            if currectOffset - starOffsetX == scrollView.bounds.width{
                progress = 1
                tagetIndx = sourceIndx
            }
            
        }else{
            progress = 1 - (currectOffset / scrollView.bounds.width - floor(currectOffset / scrollView.bounds.width))
            tagetIndx = Int(currectOffset / scrollView.bounds.width)
            sourceIndx = tagetIndx + 1
            if sourceIndx >= childVcs.count {
                sourceIndx = childVcs.count - 1
            }
        }
        delegate?.pageContentView(pageCOntentView: self, progress: progress, sourceIndex: sourceIndx, targetIndex: tagetIndx)
    }
}
extension PageContentView{
    func setCurrentIndex(currentIndex:Int) {
        isForbidScroll = true
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: false)
    }
}
