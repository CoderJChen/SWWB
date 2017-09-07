//
//  CJPresentationVC.swift
//  CJWB
//
//  Created by 星驿ios on 2017/8/2.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit

class CJPresentationVC: UIPresentationController {
    
    var presentedFrame : CGRect = CGRect.zero
    
    fileprivate lazy var coverView : UIView = UIView()
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        presentedView?.frame = presentedFrame
        
        
        setUpCoverView()
        
    }
    
}


extension CJPresentationVC{
    fileprivate func setUpCoverView(){
        
        containerView?.insertSubview(coverView, at: 0)
        
        coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        coverView.frame = containerView!.bounds
        
        let  tapGes = UITapGestureRecognizer(target: self, action: #selector( CJPresentationVC.coverViewClick))
        
        coverView.addGestureRecognizer(tapGes)
        
    }
}

// MARK:- 事件监听

extension CJPresentationVC{
    @objc fileprivate func coverViewClick(){
        print("coverViewClick")
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
