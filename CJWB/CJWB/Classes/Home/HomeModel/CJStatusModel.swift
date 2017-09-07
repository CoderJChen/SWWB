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
    
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        if let userDict = dict["user"] as? [String : AnyObject] {
            user = CJUserModel(dict: userDict)
        }
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
