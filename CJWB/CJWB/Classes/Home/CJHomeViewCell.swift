//
//  CJHomeViewCell.swift
//  CJWB
//
//  Created by 星驿ios on 2017/8/21.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit
import SDWebImage

private let edgeMargin : CGFloat = 15

class CJHomeViewCell: UITableViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var verifiedView: UIImageView!
    
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var vipView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentLabelWCons: NSLayoutConstraint!

    var viewModel : CJStatusViewModel? {
        didSet{
            // 1.nil值校验
            guard let viewModel = viewModel else {
                return
            }
            
            iconView.sd_setImage(with: viewModel.profileURL! as URL, placeholderImage: UIImage(named:"avatar_default_small"), options: [], completed: nil)
            
            // 3.设置认证的图标
            verifiedView.image = viewModel.verifiedImage
            
            // 4.昵称
            screenNameLabel.text = viewModel.status?.user?.screen_name
            
            // 5.会员图标
            vipView.image = viewModel.vipImage
            
            // 6.设置时间的Label
            timeLabel.text = viewModel.createAtText
            
            // 7.设置来源
            contentLabel.text = viewModel.status?.text
            
            // 8.设置昵称的文字颜色
            screenNameLabel.textColor = viewModel.vipImage == nil ? UIColor.black : UIColor.orange
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置微博正文的宽度约束
        contentLabelWCons.constant = UIScreen.main.bounds.width - 2 * edgeMargin
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
