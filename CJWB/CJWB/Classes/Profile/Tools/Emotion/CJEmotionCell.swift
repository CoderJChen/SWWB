//
//  CJEmotionCell.swift
//  CJWB
//
//  Created by 星驿ios on 2017/9/14.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit

class CJEmotionCell: UICollectionViewCell {
    
    fileprivate lazy var emotionBtn : UIButton = UIButton()
    
    var emotion : CJEmotionModel? {
        didSet{
            guard let emotion = emotion else {
               return
            }
            emotionBtn.setImage(UIImage(contentsOfFile: emotion.pngPath ?? ""), for: .normal)
            emotionBtn.setTitle(emotion.emojiCode, for: .normal)
            
            if emotion.isRemove {
                emotionBtn.setImage(UIImage(named:"compose_emotion_delete"), for: .normal)
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CJEmotionCell{
    fileprivate func setUpUI(){
        contentView.addSubview(emotionBtn)
        emotionBtn.frame = contentView.bounds
        
        emotionBtn.isUserInteractionEnabled = false
        emotionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        
    }
}
