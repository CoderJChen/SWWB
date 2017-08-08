//
//  UIButton-Extension.swift
//  CJWB
//
//  Created by 星驿ios on 2017/7/31.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit

extension UIButton{
    /**
     *遍历构造函数的特点
     1.遍历构造函数通常都是写在extension里面
     2.遍历构造函数init前面需要加载convenience
     3.在遍历构造函数中需要明确的调用self.init()
     */
    convenience init(imageName:String,backImageName:String) {
        self.init()
        setImage(UIImage(named:imageName), for: .normal)
        setImage(UIImage(named:imageName + "_highlighted"), for: .highlighted)
        setBackgroundImage(UIImage(named:backImageName), for: .normal)
        setBackgroundImage(UIImage(named:backImageName + "_highlighted"), for: .highlighted)
        sizeToFit()
    }
}
