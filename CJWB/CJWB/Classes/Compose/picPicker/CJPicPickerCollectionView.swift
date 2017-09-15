//
//  CJPicPickerCollectionView.swift
//  CJWB
//
//  Created by 星驿ios on 2017/9/12.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit


fileprivate let picPickerCell = "picPickerCell"
fileprivate let edgeMargin : CGFloat = 15

class CJPicPickerCollectionView: UICollectionView {
    var images : [UIImage] = [UIImage](){
        didSet{
            reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemWH = (UIScreen.main.bounds.width - 4 * edgeMargin) / 3
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        layout.minimumLineSpacing = edgeMargin
        layout.minimumInteritemSpacing = edgeMargin
        
        register(UINib(nibName:"CJPicPickerViewCell", bundle: nil), forCellWithReuseIdentifier: picPickerCell)
        
        dataSource = self
        
        contentInset = UIEdgeInsetsMake(edgeMargin, edgeMargin, 0, edgeMargin)
    }
}



extension CJPicPickerCollectionView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return images.count + 1
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:picPickerCell, for: indexPath) as! CJPicPickerViewCell
        cell.backgroundColor = UIColor.red
        cell.image = indexPath.item <= images.count - 1 ? images[indexPath.item] : nil
 
        return cell
        
    }
}
