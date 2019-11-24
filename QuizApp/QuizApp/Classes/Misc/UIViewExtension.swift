//
//  UIViewExtension.swift
//  QuizApp
//
//  Created by Aleksandr on 23/11/2019.
//  Copyright © 2019 Kurumoch Team LLC. All rights reserved.
//

import UIKit

extension UIView {
    func createShadowLayer(for layer: CALayer) -> CALayer {
        let shadowLayer = CALayer()
        
        shadowLayer.shadowOpacity = 1.0
        shadowLayer.backgroundColor = R.color.violetMain()?.cgColor
        shadowLayer.shadowColor = R.color.violetMain()?.cgColor
        shadowLayer.shadowOffset = LayerConstants.shadowOffset
        shadowLayer.shadowRadius = LayerConstants.shadowRadius
        shadowLayer.masksToBounds = false
        
        layer.masksToBounds = false
        
        layer.insertSublayer(shadowLayer, at: 0)
        
        return shadowLayer
    }
    
    func adjust(shadowLayer: CALayer, within layer: CALayer) {
        shadowLayer.cornerRadius = layer.cornerRadius
        
        let shadowLayerWidth = layer.frame.width - layer.cornerRadius / 2
        shadowLayer.frame = CGRect(
            x: (layer.frame.width - shadowLayerWidth) / 2,
            y: layer.frame.height / 2,
            width: shadowLayerWidth,
            height: layer.frame.height / 2
        )
    }
}

private extension UIView {
    enum LayerConstants {
        static let relativeWidth = CGFloat(0.83)
        static let shadowRadius = CGFloat(40)
        static let shadowOffset = CGSize(width: 0, height: 8)
    }
}
