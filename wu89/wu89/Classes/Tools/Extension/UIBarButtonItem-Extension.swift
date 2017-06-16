//
//  UIBarButtonItem-Extension.swift
//  wu89
//
//  Created by wu on 2017/6/16.
//  Copyright © 2017年 wu. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    class func createItem(image:UIImage,heightImage:UIImage) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(image, for: .normal)
        btn.setImage(heightImage, for: .highlighted)
        btn.sizeToFit()
        
        return UIBarButtonItem(customView: btn)
    }
    
    convenience init(imageName:String,hightImageName:String,size:CGSize){
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:hightImageName), for: .highlighted)
        btn.sizeToFit()
        btn.frame = CGRect(origin: CGPoint(), size: size)
        
        self.init(customView:btn)
    }
}
