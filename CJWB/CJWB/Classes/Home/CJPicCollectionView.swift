//
//  CJPicCollectionView.swift
//  CJWB
//
//  Created by 星驿ios on 2017/9/8.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit
import SDWebImage
class CJPicCollectionView: UICollectionView {
    
    var picURLs : [NSURL] = [NSURL](){
        didSet{
            self.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        dataSource = self
    }
    
}

//MARK:- collectionView的数据源方法

extension CJPicCollectionView :UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PicCell", for: indexPath) as! CJPicCollectionViewCell
        cell.picURL = picURLs[indexPath.item]
        return cell
    }
}

class CJPicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    var picURL : NSURL?{
        didSet{
            guard let picURL = picURL else {
                return
            }
            
           iconView.sd_setImage(with: picURL as URL, placeholderImage: UIImage(named: "empty_picture"), options: [], completed: nil)
        }
    }
}
