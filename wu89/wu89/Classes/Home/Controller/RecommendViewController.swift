//
//  RecommendViewController.swift
//  wu89
//
//  Created by wu on 2017/6/17.
//  Copyright © 2017年 wu. All rights reserved.
//

import UIKit


fileprivate let kItemMargin:CGFloat = 10
fileprivate let kItemW = (sWidth - 3 * kItemMargin) / 2
fileprivate let kItemH = kItemW * 3 / 4
fileprivate let kHeadViewH:CGFloat = 50

class RecommendViewController: UIViewController {
    
    fileprivate lazy var collectionView :UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.headerReferenceSize = CGSize(width: sWidth, height: kHeadViewH)
        
        let cv = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        cv.dataSource = self
        cv.backgroundColor = UIColor.purple
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cv.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        cv.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        return cv
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        setupUI()
    }
}
extension RecommendViewController{
    fileprivate func setupUI(){
        view.addSubview(collectionView)
    }
}
extension RecommendViewController:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.lightGray
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        headView.backgroundColor = UIColor.green
        return headView
    }

}
