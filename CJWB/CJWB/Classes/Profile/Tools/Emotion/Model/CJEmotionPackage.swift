//
//  CJEmotionPackage.swift
//  CJWB
//
//  Created by 星驿ios on 2017/9/13.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit

class CJEmotionPackage: NSObject {
    var emotions : [CJEmotionModel] = [CJEmotionModel]()
    init(id : String) {
        super.init()
//        1、最近分组
        if id == "" {
           addEmptyEmotion(isRecently: true)
            return
        }
//        根据id拼接info.plist的路径
        let plistPath = Bundle.main.path(forResource: "\(id)/info.plist", ofType: nil, inDirectory: "Emoticons.bundle")
//        3、根据plist文件的路径读取数据
        let arrary = NSArray(contentsOfFile: plistPath!) as! [[String : String]]
//        4、遍历数组
        var index = 0
        for var dict  in arrary {
            if let png = dict["png"] {
                dict["png"] = id + "/" + png
            }
            emotions.append(CJEmotionModel(dict: dict))
            index += 1
            
            if index == 20 {
//                添加删除表情
                emotions.append(CJEmotionModel(isEmpty: true))
                index = 0
            }
        }
//        添加空白表情
        addEmptyEmotion(isRecently: false)
    }
    
    private func addEmptyEmotion(isRecently : Bool){
        let count = emotions.count % 21
        if count == 0 && !isRecently {
            return
        }
        for _ in count..<20 {
            emotions.append(CJEmotionModel(isEmpty: true))
        }
        emotions.append(CJEmotionModel(isRemove: true))
    }
}
