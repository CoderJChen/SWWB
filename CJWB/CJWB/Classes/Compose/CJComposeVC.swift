//
//  CJComposeVC.swift
//  CJWB
//
//  Created by 星驿ios on 2017/9/11.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit
import SVProgressHUD

class CJComposeVC: UIViewController {
    
    @IBOutlet weak var textView: CJComposeTextView!
    @IBOutlet weak var picPickerView: CJPicPickerCollectionView!
    
    //MARK:- 懒加载属性
    fileprivate lazy var titleView : CJComposeTitleView = CJComposeTitleView()
    fileprivate lazy var images : [UIImage] = [UIImage]()
    fileprivate lazy var emotionVC : CJEmotionVC = CJEmotionVC {[weak self] (emotion) in
        self?.textView.insertEmotion(emotion: emotion)
        self?.textViewDidChange(self!.textView)
    }
    
    @IBOutlet weak var toolBarBottomCons: NSLayoutConstraint!
    
    @IBOutlet weak var picPicerViewHCons: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK:- 设置导航栏
        setUpNavigationBar()
        
        // 监听通知
        setUpNotification()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    
    deinit {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    
}
//MARK:- 设置UI界面
extension CJComposeVC {
    
    fileprivate func setUpNavigationBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(CJComposeVC.closeItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .plain, target: self, action: #selector(CJComposeVC.sendItemClick))
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        navigationItem.titleView = titleView
        
    }
    
    fileprivate func setUpNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(CJComposeVC.keyboardWillChangeFrame(note:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CJComposeVC.addPhotoClick), name: NSNotification.Name(rawValue: PicPickerAddPhotoNote), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CJComposeVC.removePhotoClick(note:)), name: NSNotification.Name(rawValue: PicPickerRemovePhotoNote), object: nil)
        
    }
}

extension CJComposeVC {
    
    @objc fileprivate func closeItemClick(){
//        退出键盘
        textView.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func sendItemClick(){
        
        textView.resignFirstResponder()
        let statusText = textView.getEmotionString()
        let finishedCallBack = { (isSuccess : Bool) -> () in
            if !isSuccess {
                SVProgressHUD.showError(withStatus: "发送微博失败")
                return
            }
            SVProgressHUD.showSuccess(withStatus: "发送微博成功")
            self.dismiss(animated: true, completion: nil)
        }
        
        if let image = images.first {
            CJNetWorkTools.sendStatus(statusText: statusText, image: image, isSuccess: finishedCallBack)
        }else{
            CJNetWorkTools.sendStatus(statusText: statusText, isSuccess: finishedCallBack)
        }
    }
    
    @objc fileprivate func keyboardWillChangeFrame(note : Notification){
//            1、 获取动画执行时间
        let duration = note.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
//        2、获取键盘最终的y值
        let endFrame = (note.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let y = endFrame.origin.y
//        3、计算工具栏距离底部的间距
        let margin = UIScreen.main.bounds.size.height - y
        toolBarBottomCons.constant = margin
//        执行动画
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    @IBAction func picPickerBtnClick(_ sender: Any) {
//        退出键盘
            textView.resignFirstResponder()
        picPicerViewHCons.constant = UIScreen.main.bounds.height * 0.65
//        执行动画
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func emotionBtnClick(_ sender: Any) {
//        退出键盘
        textView.resignFirstResponder()
//        切换键盘
        textView.inputView = textView.inputView != nil ? nil : emotionVC.view
//        弹出键盘
        textView.becomeFirstResponder()
    }
}
//MARK:- 添加照片和删除照片的事件
extension CJComposeVC{

    @objc fileprivate func addPhotoClick(){
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            return
        }
        
        let ipc = UIImagePickerController()
        ipc.sourceType = .photoLibrary
        ipc.delegate = self
        present(ipc, animated: true, completion: nil)
        
    }
    
    @objc fileprivate func removePhotoClick(note : Notification){
        guard let image = note.object as? UIImage else {
            return
        }
        guard let index = images.index(of: image) else {
            return
        }
        images.remove(at: index)
        picPickerView.images = images
    }
}


extension CJComposeVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        获取图片
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
//        将选中的图片添加到数组中
        images.append(image)
//        将数组赋值给collectionView,让collectionView自己去展示数据
        picPickerView.images = images
//        退出选中照片控制器
        picker.dismiss(animated: true, completion: nil)
    }
}

extension CJComposeVC : UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        self.textView.placeHolderLabel.isHidden = textView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        textView.resignFirstResponder()
    }
}
