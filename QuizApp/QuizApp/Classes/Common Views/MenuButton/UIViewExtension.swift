//
//  UiViewExtension.swift
//  QuizApp
//
//  Created by Aleksandr on 05/10/2019.
//  Copyright © 2019 Kurumoch Team LLC. All rights reserved.
//

import UIKit


extension UIView {
    @IBInspectable
    var borderRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.masksToBounds = true
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var floatingShadowRelativeWidth: CGFloat {
        get {
            fatalError("Get is not implemented")
        }
        
        set {
            let shadowLayer = CALayer()
            shadowLayer.frame = CGRect(
                x: (layer.frame.width - layer.frame.width * newValue) / 2,
                y: layer.frame.height / 2,
                width: layer.frame.width * newValue,
                height: layer.frame.height / 2
            )
            shadowLayer.cornerRadius = layer.cornerRadius
            
            shadowLayer.shadowOpacity = 1.0
            shadowLayer.backgroundColor = UIColor.violetMain.cgColor
            shadowLayer.shadowColor = UIColor.violetMain.cgColor
            shadowLayer.shadowOffset = CGSize(width: 0, height: 8)
            shadowLayer.shadowRadius = 40
            shadowLayer.masksToBounds = false
            layer.masksToBounds = false
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}
