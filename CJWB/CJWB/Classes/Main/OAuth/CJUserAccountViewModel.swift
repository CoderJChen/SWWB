//
//  CJUserAccountViewModel.swift
//  CJWB
//
//  Created by 星驿ios on 2017/8/9.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit

class CJUserAccountViewModel: NSObject {

    //MARK:- 将类设计成单例
    static let shareInstance : CJUserAccountViewModel = CJUserAccountViewModel()
    
    var account : CJUserAccount?
    
    var accountPath : String{
        
        let accountPath  = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        return (accountPath as NSString).appendingPathComponent("account.plist")
    }
    
    var isLogin : Bool{
        if account == nil {
            return false
        }
        guard let expiresDate = account?.expires_date else {
            return false
        }
        return expiresDate.compare(Date()) == ComparisonResult.orderedDescending
    }
    
    // MARK:- 重写init()函数
    override init () {
        super.init()
        // 1.从沙盒中读取中归档的信息
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? CJUserAccount
    }
}
