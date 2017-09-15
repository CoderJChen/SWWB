//
//  CJComposeTitleView.swift
//  CJWB
//
//  Created by 星驿ios on 2017/9/11.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit
import SnapKit

class CJComposeTitleView: UIView {

    // MARK:- 懒加载属性
    fileprivate lazy var titleLabel : UILabel = UILabel()
    fileprivate lazy var screenNameLabel : UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CJComposeTitleView{
    fileprivate func setUpUI(){
        addSubview(titleLabel)
        addSubview(screenNameLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }
        screenNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(titleLabel.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
        }
        
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        screenNameLabel.font = UIFont.systemFont(ofSize: 14)
        screenNameLabel.textColor = UIColor.lightGray
        titleLabel.text = "发微博"
        screenNameLabel.text = CJUserAccountViewModel.shareInstance.account?.screen_name
        
    }
}
