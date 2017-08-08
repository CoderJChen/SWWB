//
//  UIBarButtonItem-Extension.swift
//  CJWB
//
//  Created by 星驿ios on 2017/7/31.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    convenience init(imageName : String) {
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:imageName + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        self.init(customView: btn)
    }
}
