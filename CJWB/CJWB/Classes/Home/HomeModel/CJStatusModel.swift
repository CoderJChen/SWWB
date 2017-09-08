//
//  CJStatusModel.swift
//  CJWB
//
//  Created by 星驿ios on 2017/8/18.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit

class CJStatusModel: NSObject {
    //MARK:- 属性
    var created_at : String?
    var source : String?
    var text : String?
    var mid : Int = 0
    var user : CJUserModel?
    var pic_urls : [[String : String]]?     // 微博的配图
    var retweeted_status : CJStatusModel? // 微博对应的转发的微博
    
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        if let userDict = dict["user"] as? [String : AnyObject] {
            user = CJUserModel(dict: userDict)
        }
        
        if let retweetedStatusDict = dict["retweeted_status"] as?[String : AnyObject] {
            retweeted_status = CJStatusModel(dict: retweetedStatusDict)
        }
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
