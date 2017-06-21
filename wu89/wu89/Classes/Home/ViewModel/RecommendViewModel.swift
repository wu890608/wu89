//
//  RecommendViewModel.swift
//  wu89
//
//  Created by wu on 2017/6/17.
//  Copyright © 2017年 wu. All rights reserved.
//

import UIKit

class RecommendViewModel {
    func requestData() {
        
        let nowDate = NSDate()
        let time = nowDate.timeIntervalSince1970
        
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotcate", parameters: ["limit":"4","offset":"0","time":"\(time)" as NSString]) { (result) in
            print(result)
        }
    }
}
