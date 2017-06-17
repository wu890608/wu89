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

class RecommendViewController: UIViewController {
    
    fileprivate lazy var collectionView :UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: sWidth, height: 50)
        
        let cv = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        cv.dataSource = self
        return cv
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.purple
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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

}
