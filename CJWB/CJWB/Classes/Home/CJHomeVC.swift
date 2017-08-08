//
//  CJHomeVC.swift
//  CJWB
//
//  Created by 星驿ios on 2017/7/26.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit

class CJHomeVC: CJBaseVC {

    fileprivate lazy var titleBtn : CJTitleButton = CJTitleButton()
    // 注意:在闭包中如果使用当前对象的属性或者调用方法,也需要加self
    // 两个地方需要使用self : 1> 如果在一个函数中出现歧义 2> 在闭包中使用当前对象的属性和方法也需要加self
    fileprivate lazy var popoverAnimation : CJPopoverAnimation = CJPopoverAnimation{[weak self] (presented) -> () in
        self!.titleBtn.isSelected = presented
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView.addRotationAnim()
        
        if !isLogin {
            return
        }
        
        setupNavigationBar()
        
    }
    

}

extension CJHomeVC{
    fileprivate func setupNavigationBar(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        titleBtn.setTitle("coderCJ", for: .normal)
        titleBtn.addTarget(self, action: #selector(CJHomeVC.titleBtnClick(_ :)), for: .touchUpInside)
        navigationItem.titleView = titleBtn
    }
}

extension CJHomeVC{
    
    @objc fileprivate func titleBtnClick(_ titleBtn:CJTitleButton){
        
        titleBtn.isSelected = !titleBtn.isSelected
        
        let popoverVC = CJPopoverViewController()
        
        popoverVC.modalPresentationStyle = .custom
        popoverVC.transitioningDelegate = popoverAnimation
        popoverAnimation.presentedFrame = CGRect(x: 100, y: 64, width: 180, height: 250)
        
        present(popoverVC, animated: true, completion: nil)
        
        
    }
}




