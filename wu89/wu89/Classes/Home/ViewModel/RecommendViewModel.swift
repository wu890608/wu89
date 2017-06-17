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
        NetworkTools.requestData(type: .GET, URLString: "", parameters: [:]) { (result) in
            
        }
    }
}
