//
//  CJStatusViewModel.swift
//  CJWB
//
//  Created by 星驿ios on 2017/8/18.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit

class CJStatusViewModel: NSObject {
    // MARK:- 定义属性
    var status : CJStatusModel?
    
    var cellHeight : CGFloat = 0
    // MARK:- 对数据处理的属性
    var sourceText : String?            // 处理来源
    var createAtText : String?          // 处理创建时间
    var verifiedImage : UIImage?        // 处理用户认证图标
    var vipImage : UIImage?             // 处理用户会员等级
    var profileURL : NSURL?             // 处理用户头像的地址
    var picURLs : [NSURL] = [NSURL]()   // 处理微博配图的数据
    
    init(status : CJStatusModel) {
        
        self.status = status
        
        if let source = status.source, source != "" {
            let startIndex = (source as NSString).range(of: ">").location + 1
            let length = (source as NSString).range(of: "</").location - startIndex
            
            // 1.2.截取字符串
            sourceText = (source as NSString).substring(with: NSRange(location: startIndex, length: length))
            
        }
        
        // 2.处理时间
        if let createAt = status.created_at {
            createAtText = NSDate.createDateString(createAtStr: createAt)
        }
        
        // 3.处理认证
        let verifiedType = status.user?.verified_type ?? -1
        switch verifiedType {
        case 0:
            verifiedImage = UIImage(named: "avatar_vip")
        case 2, 3, 5:
            verifiedImage = UIImage(named: "avatar_enterprise_vip")
        case 220:
            verifiedImage = UIImage(named: "avatar_grassroot")
        default:
            verifiedImage = nil
        }
        
        // 4.处理会员图标
        let mbrank = status.user?.mbrank ?? 0
        if mbrank > 0 && mbrank <= 6 {
            vipImage = UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        
        // 5.用户头像的处理
        let profileURLString = status.user?.profile_image_url ?? ""
        profileURL = NSURL(string: profileURLString)

    }

}
