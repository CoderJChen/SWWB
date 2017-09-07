//
//  CJWelcomeVC.swift
//  CJWB
//
//  Created by 星驿ios on 2017/8/9.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit
import SDWebImage

class CJWelcomeVC: UIViewController {
//    拖线属性
    @IBOutlet weak var iconViewBottomCons: NSLayoutConstraint!
    @IBOutlet weak var iconView: UIImageView!
//    系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
//        设置头像
        let profileUrlString = CJUserAccountViewModel.shareInstance.account?.avatar_large
        // ?? : 如果??前面的可选类型有值,那么将前面的可选类型进行解包并且赋值
        // 如果??前面的可选类型为nil,那么直接使用??后面的值
        let url = URL(string: profileUrlString ?? "")
        
        iconView.sd_setImage(with: url, placeholderImage: UIImage(named:"avatar_default_big"), options: SDWebImageOptions.retryFailed, progress: nil, completed: nil)
//        改变约束的值
        iconViewBottomCons.constant = UIScreen.main.bounds.height - 200
        // 2.执行动画
        // Damping : 阻力系数,阻力系数越大,弹动的效果越不明显 0~1
        // initialSpringVelocity : 初始化速度
       UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: [], animations: { 
        self.view.layoutIfNeeded()
       }) { (_) in
        UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
