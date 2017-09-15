//
//  CJEmotionManger.swift
//  CJWB
//
//  Created by 星驿ios on 2017/9/13.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit

class CJEmotionManger: NSObject {
    var packages : [CJEmotionPackage] = [CJEmotionPackage]()
    
     override init() {
//        添加最近表情的包
        packages.append(CJEmotionPackage(id: ""))
//        添加默认的表情包
        packages.append(CJEmotionPackage(id: "com.sina.default"))
//        添加emoji表情的包
        packages.append(CJEmotionPackage(id: "com.apple.emoji"))
//        添加浪小花表情的包
        packages.append(CJEmotionPackage(id: "com.sina.lxh"))
    }
}
