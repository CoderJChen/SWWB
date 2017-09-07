//
//  CJVisitorView.swift
//  CJWB
//
//  Created by 星驿ios on 2017/8/2.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit

class CJVisitorView: UIView {

    @IBOutlet weak var rotationView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    class func visitorView() -> CJVisitorView{
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)!.first as! CJVisitorView
    }
    
    func setupVisitorViewInfo(_ iconName:String,title:String){
        iconView.image = UIImage(named: iconName)
        tipLabel.text = title
        rotationView.isHidden = true
    }
    
    func addRotationAnim() -> Void {
//        旋转
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnim.fromValue = 0
        rotationAnim.toValue = Double.pi * 2
        rotationAnim.repeatCount =  MAXFLOAT
        rotationAnim.duration = 5
        rotationAnim.isRemovedOnCompletion = false
        rotationView.layer.add(rotationAnim, forKey: nil)
        
    }
    }
