//
//  CJTitleButton.swift
//  CJWB
//
//  Created by 星驿ios on 2017/8/2.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit

class CJTitleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(named:"navigationbar_arrow_down"), for: .normal)
        setImage(UIImage(named:"navigationbar_arrow_up"), for: .selected)
        setTitleColor(UIColor.black, for: .normal)
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = (titleLabel?.frame.size.width)! + 5
    }
}
