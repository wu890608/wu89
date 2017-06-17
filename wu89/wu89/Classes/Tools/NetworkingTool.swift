//
//  NetworkingTool.swift
//  Neworking
//
//  Created by wu on 2017/6/17.
//  Copyright © 2017年 wu. All rights reserved.
//

import Foundation
import Alamofire

enum MethodType {
    case GET
    case POST
}
class NetworkTools {
    class func requestData(type:MethodType,URLString:String,parameters:[String:NSString]? = nil,finish:@escaping (_ result:AnyObject)->()) {

        let method = type == .GET ? HTTPMethod.get :HTTPMethod.post

        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else{
                print(response.result.error as Any)
                return
            }
            finish(result as AnyObject)
        }
        
        
    }
}
