//
//  NSDate-Extension.swift
//  CJWB
//
//  Created by 星驿ios on 2017/8/18.
//  Copyright © 2017年 CJ. All rights reserved.
//

import Foundation

extension NSDate{
    class func createDateString(createAtStr : String) -> String {
//        1、创建时间格式化对象
        let fmt = DateFormatter()
        fmt.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        fmt.locale = Locale(identifier: "en")
        //        2、将字符串时间转为Date
        guard let createDate = fmt.date(from: createAtStr) else {
            return ""
        }
//3、创建当前时间
        let nowDate = Date()
        
//        计算创建时间和当前时间的时间差
        let interval = Int(nowDate.timeIntervalSince(createDate))
        
//        对时间间隔处理
//        显示刚刚
        if interval < 60 {
            return "刚刚"
        }
//        59分钟前
        if interval < 60 * 60 {
            return "\(interval / 60)分钟前"
        }

        if interval < 60 * 60 * 24 {
            return "\(interval / (60 * 60))小时前"
        }
        

        
        let calendar = Calendar.current
        
        if calendar.isDateInYesterday(createDate) {
            fmt.dateFormat = "昨天 HH:mm"
            let timeStr = fmt.string(from: createDate)
            return timeStr
        }
    
        let cmps = calendar.dateComponents([Calendar.Component.year], from: createDate, to: nowDate)
        
        
        if cmps.year! < 1 {
            fmt.dateFormat = "MM-dd HH:mm"
            let timeStr = fmt.string(from: createDate)
            return timeStr
        }
        fmt.dateFormat = "yyyy-MM-dd HH:mm"
        let timeStr = fmt.string(from: createDate)
        return timeStr
        
    }
}
