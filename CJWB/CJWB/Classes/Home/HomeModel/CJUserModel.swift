//
//  CJUserModel.swift
//  CJWB
//
//  Created by 星驿ios on 2017/8/18.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit

class CJUserModel: NSObject {

    // MARK:- 属性
    var profile_image_url : String?         // 用户的头像
    var screen_name : String?               // 用户的昵称
    var verified_type : Int = -1            // 用户的认证类型
    var mbrank : Int = 0                    // 用户的会员等级
    
    init(dict : [String : AnyObject]) {
        
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
