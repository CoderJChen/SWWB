//
//  CJHomeVC.swift
//  CJWB
//
//  Created by 星驿ios on 2017/7/26.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh

class CJHomeVC: CJBaseVC {

    fileprivate lazy var titleBtn : CJTitleButton = CJTitleButton()
    // 注意:在闭包中如果使用当前对象的属性或者调用方法,也需要加self
    // 两个地方需要使用self : 1> 如果在一个函数中出现歧义 2> 在闭包中使用当前对象的属性和方法也需要加self

    fileprivate lazy var popoverAnimation : CJPopoverAnimation = CJPopoverAnimation{[weak self] (presented) -> () in
        self!.titleBtn.isSelected = presented
    }
    
    fileprivate lazy var viewModels : [CJStatusViewModel] = [CJStatusViewModel]()
    
    fileprivate lazy var tipLabel : UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        没登录时设置的内容
        visitorView.addRotationAnim()
        if !isLogin {
            return
        }
//        设置导航栏的内容
        setupNavigationBar()
        
//        请求数据
//        loadStatuses()
        
//        设置估算高亮
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        setUpHeadView()
        setFooterView()
        setUpTipLabel()
    }
    

}

//MARK:- 设置UI界面

extension CJHomeVC{
    
    fileprivate func setupNavigationBar(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        titleBtn.setTitle("coderCJ", for: .normal)
        titleBtn.addTarget(self, action: #selector(CJHomeVC.titleBtnClick(_ :)), for: .touchUpInside)
        navigationItem.titleView = titleBtn
    }
    
    fileprivate func setUpHeadView(){
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(CJHomeVC.loadNewStatuses))
//        设置刷新属性
        header?.setTitle("下拉刷新", for: .idle)
        header?.setTitle("释放刷新", for: .pulling)
        header?.setTitle("加载中", for: .refreshing)
//        设置tableView的header
        tableView.mj_header = header
//        进入刷新状态
        tableView.mj_header.beginRefreshing()
        
    }
    fileprivate func setFooterView(){
        tableView.mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(CJHomeVC.loadMoreStatuses))
    }
    
    fileprivate func setUpTipLabel(){
        navigationController?.navigationBar.insertSubview(tipLabel, at: 0)
        tipLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 32)
        tipLabel.backgroundColor = UIColor.orange
        tipLabel.textColor = UIColor.white
        tipLabel.font = UIFont.systemFont(ofSize: 14)
        tipLabel.textAlignment = .center
        tipLabel.isHidden = true
    }
}
//MARK:- 事件监听的函数
extension CJHomeVC{
    
    @objc fileprivate func titleBtnClick(_ titleBtn:CJTitleButton){
        
        let popoverVC = CJPopoverViewController()
        
        popoverVC.modalPresentationStyle = .custom
        popoverVC.transitioningDelegate = popoverAnimation
        popoverAnimation.presentedFrame = CGRect(x: 100, y: 64, width: 180, height: 250)
        
        present(popoverVC, animated: true, completion: nil)
        
        
    }
    
    @objc fileprivate func loadNewStatuses(){
        self.loadStatuses(isNewData: true)
    }
    
    @objc fileprivate func loadMoreStatuses(){
        self.loadStatuses(isNewData: false)
    }
    
}
//MARK:- 请求数据
extension CJHomeVC{
    fileprivate func loadStatuses(isNewData : Bool){
        
        var since_id = 0
        
        var max_id = 0
        
        if isNewData {
            since_id = viewModels.first?.status?.mid ?? 0
        }else{
            max_id = viewModels.last?.status?.mid ?? 0
            max_id = max_id == 0 ? 0 : (max_id - 1)
        }
        
        CJNetWorkTools.loadStatuses(since_id: since_id, max_id: max_id) { (result) in
            
            // 1.获取可选类型中的数据
            guard let resultArray = result else {
                
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
                
                return
            }
            
            var tempViewModel = [CJStatusViewModel]()
            for statusDict in resultArray{
                let status = CJStatusModel(dict: statusDict)
                let viewModel = CJStatusViewModel(status: status)
                tempViewModel.append(viewModel)
            }
            
            if isNewData{
                self.viewModels = tempViewModel + self.viewModels
            } else{
                self.viewModels += tempViewModel
            }
            
            self.cacheImage(viewModels: tempViewModel)
        }
            
        
        
    }
    
    fileprivate func cacheImage(viewModels : [CJStatusViewModel]){
        let group = DispatchGroup()
        
        for viewModel in viewModels {
            for picURL in viewModel.picURLs {
                group.enter()
                SDWebImageManager.shared().loadImage(with: picURL as URL, options: [], progress: nil, completed: { (_, _, _, _, _, _) in
                    group.leave()
                })
            }
        }
        
//        刷新表格
        
        group.notify(queue: DispatchQueue.main) { 
            self.tableView.reloadData()
            
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            // 显示提示的Label
            self.showTipLabel(count: viewModels.count)
        }
        
        
    }
    
    fileprivate func showTipLabel(count : Int){
        // 1.设置tipLabel的属性
        tipLabel.isHidden = false
        tipLabel.text = count == 0 ? "没有新数据" : "\(count) 条形微博"
        
        // 2.执行动画
        UIView.animate(withDuration: 1.0, animations: { 
            self.tipLabel.frame.origin.y = 44
        }) { (_) in
            UIView.animate(withDuration: 1.0, animations: { 
                self.tipLabel.frame.origin.y = 10
            }, completion: { (_) in
                self.tipLabel.isHidden = true
            })
        }
        
    }
}

extension CJHomeVC{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! CJHomeViewCell
        cell.viewModel = viewModels[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewModel = viewModels[indexPath.row]
        return viewModel.cellHeight
    }
}





