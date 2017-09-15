//
//  CJEmotionModel.swift
//  CJWB
//
//  Created by 星驿ios on 2017/9/13.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit

class CJEmotionModel: NSObject {
    //MARK:- 定义属性
    var code : String? {
        didSet{
            guard let code = code else {
                return
            }
//            1、创建扫描器
            let scanner = Scanner(string: code)
//            2、调用方法，扫描出code中的值
            var value : UInt32 = 0
            scanner.scanHexInt32(&value)
//            3、将value转成字符
            let c = Character(UnicodeScalar(value)!)
//            4、将字符转成字符串
            emojiCode = String(c)
        }
    }
    var png : String?{
        didSet{
            guard let png = png else {
                return
            }
            pngPath = Bundle.main.bundlePath + "/Emoticons.bundle/" + png
        }
    }
    var chs : String?
    var pngPath : String?
    var emojiCode : String?
    var isRemove : Bool = false
    var isEmpty : Bool = false
    
    init(dict : [String : String]){
        super.init()
        setValuesForKeys(dict)
    }
    init(isRemove : Bool){
        self.isRemove = isRemove
    }
    init(isEmpty : Bool) {
        self.isEmpty = isEmpty
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    override var description: String{
        return dictionaryWithValues(forKeys: ["emojiCode", "pngPath", "chs"]).description
    }
}
