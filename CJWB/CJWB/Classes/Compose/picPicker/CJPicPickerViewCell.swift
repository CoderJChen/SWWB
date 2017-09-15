//
//  CJPicPickerViewCell.swift
//  CJWB
//
//  Created by 星驿ios on 2017/9/13.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit

class CJPicPickerViewCell: UICollectionViewCell {
    //MARK:- 控件的属性
    @IBOutlet weak var addPhotoBtn: UIButton!
    @IBOutlet weak var removePhotoBtn: UIButton!

    @IBOutlet weak var imageView: UIImageView!
    //MARK:- 定义属性
    var image : UIImage? {
        didSet{
            if image != nil {
                imageView.image = image
                addPhotoBtn.isUserInteractionEnabled = false
                removePhotoBtn.isHidden = false
            }else{
                imageView.image = nil
                addPhotoBtn.isUserInteractionEnabled = true
                removePhotoBtn.isHidden = true
            }
        }
    }
    
    //MARK:- 事件监听
    @IBAction func addPhotoClick(_ sender: Any) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: PicPickerAddPhotoNote), object: nil)
        
    }
    
    @IBAction func removePhotoClick(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:PicPickerRemovePhotoNote), object: imageView.image)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
