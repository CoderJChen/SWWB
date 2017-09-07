//
//  CJBaseVC.swift
//  CJWB
//
//  Created by 星驿ios on 2017/7/31.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit

class CJBaseVC: UITableViewController{
    
    // MARK:- 懒加载属性
    lazy var visitorView : CJVisitorView = CJVisitorView.visitorView()
    
    var isLogin : Bool = CJUserAccountViewModel.shareInstance.isLogin
    
    override func loadView() {
        isLogin ? super.loadView() : setUpVisitorView()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationItems()
    }

}

extension CJBaseVC{
   fileprivate func setUpVisitorView(){
        view = visitorView
        visitorView.registerBtn.addTarget(self, action: #selector(CJBaseVC.registerBtnClick), for: .touchUpInside)
        visitorView.loginBtn.addTarget(self, action: #selector(CJBaseVC.loginBtnClick), for: .touchUpInside)
    }
    
    fileprivate func setUpNavigationItems(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(CJBaseVC.registerBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(CJBaseVC.loginBtnClick))
    }
}

extension CJBaseVC{
    @objc fileprivate func registerBtnClick(){
        print("registerBtnClick")
    }
    @objc fileprivate func loginBtnClick(){
        print("loginBtnClick")
        let oauthVC = CJOAuthVC()
        let oauthNav = UINavigationController(rootViewController: oauthVC)
        
        present(oauthNav, animated: true, completion: nil)
    }
}
