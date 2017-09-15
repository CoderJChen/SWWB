//
//  CJEmotionVC.swift
//  CJWB
//
//  Created by 星驿ios on 2017/9/13.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit

private let EmoticonCell = "EmoticonCell"

class CJEmotionVC: UIViewController {

    var emotionCallBack : ( _ emotion :CJEmotionModel) -> ()
    
    fileprivate lazy var collectionView : UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: CJEmotionCollectionViewLayout())
    fileprivate lazy var toolBar : UIToolbar = UIToolbar()
    fileprivate lazy var manager = CJEmotionManger()
    
    init(emotionCallBack : @escaping ( _ emotion :CJEmotionModel) -> ()){
        self.emotionCallBack = emotionCallBack
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }

}

extension CJEmotionVC{
    fileprivate func setUpUI(){
        view.addSubview(collectionView)
        view.addSubview(toolBar)
        
        collectionView.backgroundColor = UIColor.purple
        toolBar.backgroundColor = UIColor.darkGray
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        let views = ["tBar" : toolBar,"cView" : collectionView] as [String : Any]
        let cons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tBar]-0-|", options: [], metrics: nil, views: views)
        view.addConstraints(cons)
        
        
        prepareForCollectionView()
        
        prepareForToolBar()
       
    }
    
    fileprivate func prepareForCollectionView(){
        collectionView.register(CJEmotionCell.self, forCellWithReuseIdentifier: EmoticonCell)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    fileprivate func prepareForToolBar(){
        let titles = ["最近","默认","emoji","浪小花"]
        var index = 0
        var tempItems = [UIBarButtonItem]()
        for title in titles {
            let item = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(CJEmotionVC.itemClick(item:)))
            item.tag = index
            index += 1
            tempItems.append(item)
            tempItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
            
        }
        tempItems.removeLast()
        toolBar.items = tempItems
        toolBar.tintColor = UIColor.orange
    }
    
    @objc fileprivate func itemClick(item : UIBarButtonItem){
        let tag = item.tag
        let indexPath = NSIndexPath(item: 0, section: tag)
        collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: true)
    }
}


extension CJEmotionVC : UICollectionViewDataSource, UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return manager.packages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmoticonCell, for: indexPath) as! CJEmotionCell
        let package = manager.packages[indexPath.section]
        let emotion =  package.emotions[indexPath.item]
        cell.emotion = emotion
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let package = manager.packages[section]
        return package.emotions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let packege = manager.packages[indexPath.section]
        let emotion = packege.emotions[indexPath.item]
        
        emotionCallBack(emotion)
    }
    
    fileprivate func insertRecentlyEmotion(emotion : CJEmotionModel){
        if emotion.isRemove || emotion.isEmpty {
            return
        }
        if (manager.packages.first?.emotions.contains(emotion))! {
            
            let index = (manager.packages.first?.emotions.index(of: emotion))
            manager.packages.first?.emotions.remove(at: index!)
        }else{
            manager.packages.first?.emotions.remove(at: 19)
        }
        
        manager.packages.first?.emotions.insert(emotion, at: 0)
    }
}


class CJEmotionCollectionViewLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        let itemWH = UIScreen.main.bounds.width / 7
        
        itemSize = CGSize(width: itemWH, height: itemWH)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        collectionView?.isPagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        let insetMargin = ((collectionView?.bounds.height)! - 3*itemWH) / 2
        collectionView?.contentInset = UIEdgeInsetsMake(insetMargin, 0, insetMargin, 0)
    }
}
