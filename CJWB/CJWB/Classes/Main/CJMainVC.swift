//
//  CJMainVC.swift
//  CJWB
//
//  Created by 星驿ios on 2017/7/26.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit

class CJMainVC: UITabBarController {
    
    private var imageNames = ["tabbar_home","tabbar_message_center","","tabbar_discover","tabbar_profile"]
    fileprivate lazy var composeBtn : UIButton = UIButton(imageName: "tabbar_compose_icon_add", backImageName: "tabbar_compose_button")
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        guard let jsonPath = Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil) else {
//            print("")
//            return
//        }
//        
//        guard let  jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) else {
//            print("")
//            return
//        }
//        guard let anyObject = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) else {
//            print("")
//            returnr
//        }
//        
//        guard let dictArray = anyObject as? [[String:AnyObject]]  else {
//            return
//        }
//        for dict in dictArray {
//            guard let vcName = dict["vcName"] as? String else {
//                continue
//            }
//            guard let title = dict["title"] as? String else {
//                continue
//            }
//            guard let imageName = dict["imageName"] as? String else{
//                continue
//            }
//            addChildVC(vcName, title: title, imageName: imageName)
//        }
        
        
//        addChildVC(childVC: CJHomeVC(), title: "首页", imageName: "tabbar_home")
//        addChildVC(childVC: CJMessageVC(), title: "消息", imageName: "tabbar_message_center")
//        addChildVC(childVC: CJDiscoverVC(), title: "广场", imageName: "tabbar_discover")
//        addChildVC(childVC: CJProfileVC(), title: "我", imageName: "tabbar_profile")
        
        // Do any additional setup after loading the view.
        setUpComposeBtn()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        便利所有的item
        for i  in 0 ..< tabBar.items!.count {
           let item = tabBar.items![i]
            if i == 2 {
                item.isEnabled = false
                continue
            }
            item.selectedImage = UIImage(named: imageNames[i] + "_highlighted")
        }
    }
    
    private func addChildVC(_ childName:String,title:String,imageName:String){
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            print("没有获取命名空间")
            return
        }
        guard let childVcClass = NSClassFromString(nameSpace + "." + childName) else {
            print("没有获取到字符串对应的Class")
            return
        }
        guard let childVcType = childVcClass as? UIViewController.Type else {
            print("没有获取对应控制器的类型")
            return
        }
        let childVC = childVcType.init()
        
        childVC.title = title
        childVC.tabBarItem.image = UIImage(named: imageName)
        childVC.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        let childNav = UINavigationController(rootViewController: childVC)
        addChildViewController(childNav)
    }

}
//MARK:- 设置UI界面
extension CJMainVC{
    fileprivate func setUpComposeBtn(){
        tabBar.addSubview(composeBtn)
        composeBtn.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.size.height*0.5)
        composeBtn.addTarget(self, action:#selector(CJMainVC.composeBtnClick), for: .touchUpInside)
    }
}
//MARK:- 时间监听
extension CJMainVC{

    @objc fileprivate func composeBtnClick(){
        print("composeBtnClick")
    }
}





