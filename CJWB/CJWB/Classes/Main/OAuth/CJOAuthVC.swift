//
//  CJOAuthVC.swift
//  CJWB
//
//  Created by 星驿ios on 2017/8/9.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit
import SVProgressHUD

class CJOAuthVC: UIViewController {
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
//       设置导航栏的内容
        setUpNavigationBar()
//        加载网页
        loadPage()
        // Do any additional setup after loading the view.
    }

}

extension CJOAuthVC{
    fileprivate func setUpNavigationBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(CJOAuthVC.closeItemClick))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(CJOAuthVC.fillItemClick))
        
        title = "登录页面"
    }
    
    fileprivate func loadPage(){
        // 1.获取登录页面的URLString
//        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_uri)"
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=1568399787&redirect_uri=http://"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        webView.loadRequest(request)
        
        
    }
}

extension CJOAuthVC{
    @objc fileprivate func closeItemClick(){
        dismiss(animated: true, completion: nil)
    
    }
    @objc fileprivate func fillItemClick(){
        let jsCode = "document.getElementById('userId').value='18052128458';document.getElementById('passwd').value='chenjie';"
        webView.stringByEvaluatingJavaScript(from: jsCode)
        
    }

}

extension CJOAuthVC:UIWebViewDelegate{
    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool{
    
        guard let url = request.url else {
            return true
        }
        
        let urlString = url.absoluteString
        guard urlString.contains("code=") else {
            return true
        }
        
        let code = urlString.components(separatedBy: "code=").last!
        loadAccessToken(code: code)
        
        return false
    }
    
    public func webViewDidStartLoad(_ webView: UIWebView){
        SVProgressHUD.show()
    }
    
    
    public func webViewDidFinishLoad(_ webView: UIWebView){
        SVProgressHUD.dismiss()
    }
    
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error){
        SVProgressHUD.dismiss()
    }
}
extension CJOAuthVC{
    fileprivate func loadAccessToken(code:String){
        CJNetWorkTools.loadAccessToken(code: code) { (response) in
            guard let accountDict = response else{
                print("没有获取授权后的数据")
                return
            }
            
            let account = CJUserAccount(dict: accountDict)
            print(accountDict)
            print(account)
            self.loadUserInfo(account: account)
            
        }
    }
    fileprivate func loadUserInfo(account : CJUserAccount){
        guard let accessToken = account.access_token else {
            return
        }
        guard let uid = account.uid else {
            return
        }
        CJNetWorkTools.loadUserInfo(accessToken: accessToken, uid: uid) { (response) in
            guard let userInfoDict = response else{
                return
            }
            account.screen_name = userInfoDict["screen_name"] as? String
            account.avatar_large = userInfoDict["avatar_large"] as? String
            NSKeyedArchiver.archiveRootObject(account, toFile: CJUserAccountViewModel.shareInstance.accountPath)
            CJUserAccountViewModel.shareInstance.account = account
//            print(userInfoDict)
            self.dismiss(animated: false, completion: {
                UIApplication.shared.keyWindow?.rootViewController = CJWelcomeVC()
            })
        }
    }
}

