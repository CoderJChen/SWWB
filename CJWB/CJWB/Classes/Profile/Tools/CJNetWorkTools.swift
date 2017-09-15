//
//  CJNetWorkTools.swift
//  CJWB
//
//  Created by 星驿ios on 2017/8/9.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit
import Alamofire

//定义枚举类型

enum RequestType {
    case GET
    case POST
}

//class CJNetWorkTools:  NSObject{
//    static let shareInstance : CJNetWorkTools = {
//        let tools = CJNetWorkTools()
//        return tools
//    }()
//}


class CJNetWorkTools {
    
    class func reuqest(_ type : RequestType,urlString : String,parameters : [String : Any]? = nil,finishedCallBack :@escaping (_ result : AnyObject?) -> ()){
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(urlString, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            guard let result = response.result.value else{
                print(response.result.error as Any)
                return
            }
            finishedCallBack(result as AnyObject)
        }
    }
}

// MARK:- 请求AccessToken
extension CJNetWorkTools{
    class func loadAccessToken(code : String,finishedCallBack : @escaping(_ result : [String : AnyObject]?) -> ()) {
        // 1.获取请求的URLString
        let urlString = "https://api.weibo.com/oauth2/access_token"
        
        // 2.获取请求的参数
        let parameters = ["client_id" : app_key, "client_secret" : app_secret, "grant_type" : "authorization_code", "redirect_uri" : redirect_uri, "code" : code]
        
        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
            
            guard let result = response.result.value else{
                print(response.result.error!)
                return
            }
            finishedCallBack(result as? [String : AnyObject])
        }

    }
}

// MARK:- 请求用户的信息
extension CJNetWorkTools{
    class func loadUserInfo(accessToken : String,uid : String,finishedCallBack:@escaping(_ result : [String : AnyObject]?)->()){
        // 1.获取请求的URLString
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        // 2.获取请求的参数
        let parameters = ["access_token" : accessToken, "uid" : uid]
        
        Alamofire.request(urlString, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            guard let result = response.result.value else{
                print(response.result.error!)
                return
            }
            finishedCallBack(result as? [String : AnyObject])
        }

    }
}

// MARK:- 请求首页数据
extension CJNetWorkTools{
    class func loadStatuses(since_id : Int,max_id : Int,finished : @escaping (_ result : [[String : AnyObject]]?) -> ()){
        // 1.获取请求的URLString
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
//        2、获取请求的参数
        let accessToken = (CJUserAccountViewModel.shareInstance.account?.access_token)!
        
        let parameters = ["access_token" : accessToken,"since_id":"\(since_id)","max_id":"\(max_id)"]
        
        Alamofire.request(urlString, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            // 1.获取字典的数据
            guard let resultDict = response.result.value as? [String : AnyObject] else {
                return
            }
            finished(resultDict["statuses"] as? [[String : AnyObject]])
            
        }
        
    }
}

// MARK:- 发送微博
extension CJNetWorkTools{
    class func sendStatus(statusText : String, isSuccess : @escaping (_ isSuccess : Bool) -> ()) {
        let urlString = "https://api.weibo.com/2/statuses/update.json"
        // 2.获取请求的参数
        let parameters = ["access_token" : (CJUserAccountViewModel.shareInstance.account?.access_token)!, "status" : statusText]
        
        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in

            if response.result.value != nil {
                isSuccess(true)
            } else {
                isSuccess(false)
            }
        }
    }
}

// MARK:- 发送微博并且携带照片

extension CJNetWorkTools{
    class func sendStatus(statusText : String, image : UIImage, isSuccess : @escaping(_ isSuccess : Bool) -> ()) {
        // 1.获取请求的URLString
        let urlString = "https://api.weibo.com/2/statuses/upload.json"
        
        // 2.获取请求的参数
        let parameters = ["access_token" : (CJUserAccountViewModel.shareInstance.account?.access_token)!, "status" : statusText]
        Alamofire.upload(multipartFormData: { (formData) in
            
        }, usingThreshold: UInt64.init(), to: urlString, method: .post, headers: parameters) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    debugPrint(response)
                    isSuccess(true)
                }
            case .failure(let encodingError):
                isSuccess(false)
                print(encodingError)
            }
        }
        
    }
    
}






