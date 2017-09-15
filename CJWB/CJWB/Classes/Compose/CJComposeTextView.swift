//
//  CJComposeTextView.swift
//  CJWB
//
//  Created by 星驿ios on 2017/9/11.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit
import SnapKit

class CJComposeTextView: UITextView {
    lazy var placeHolderLabel : UILabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUI()
    }
}


extension CJComposeTextView{

    fileprivate func setUpUI(){
//        添加子控件
        addSubview(placeHolderLabel)
        placeHolderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(10)
        }
        
        placeHolderLabel.textColor = UIColor.lightGray
        placeHolderLabel.font = font
        
        placeHolderLabel.text = "分享新鲜事..."
        textContainerInset = UIEdgeInsetsMake(6, 7, 0, 7)
        
    }
}

