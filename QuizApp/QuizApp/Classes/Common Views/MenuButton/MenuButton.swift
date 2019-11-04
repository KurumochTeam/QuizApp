//
//  MenuButton.swift
//  QuizApp
//
//  Created by Aleksandr on 05/10/2019.
//  Copyright © 2019 Kurumoch Team LLC. All rights reserved.
//

import UIKit

class MenuButton: UIView, NibOwnerLoadable {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var containerView: UIView!
    
    private var onTapAction: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addCornerRadius()
        addFloatingShadow()
    }
    
    func configure(title: String, image: UIImage?, tapAction: (() -> ())?) {
        self.titleLabel.text = title
        imageView.image = image
        
        onTapAction = tapAction
    }
    
    @IBAction private func didTapButton(_ sender: UIButton) {
        onTapAction?()
    }
}

private extension MenuButton {
    struct LayerConstants {
        static let relativeWidth = CGFloat(0.83)
        static let shadowRadius = CGFloat(40)
        static let shadowOffset = CGSize(width: 0, height: 8)
    }
    
    func addCornerRadius() {
        containerView.layer.cornerRadius =
            layer.frame.height * LayerConstants.relativeWidth / 2
        
        containerView.layer.masksToBounds = true
    }
    
    func addFloatingShadow() {
        let shadowLayerWidth = layer.frame.width - containerView.layer.cornerRadius / 2
        let shadowLayer = CALayer()
        shadowLayer.frame = CGRect(
            x: (layer.frame.width - shadowLayerWidth) / 2,
            y: layer.frame.height / 2,
            width: shadowLayerWidth,
            height: layer.frame.height / 2
        )
        
        shadowLayer.cornerRadius = containerView.layer.cornerRadius
        
        shadowLayer.shadowOpacity = 1.0
        shadowLayer.backgroundColor = R.color.violetMain()?.cgColor
        shadowLayer.shadowColor = R.color.violetMain()?.cgColor
        shadowLayer.shadowOffset = LayerConstants.shadowOffset
        shadowLayer.shadowRadius = LayerConstants.shadowRadius
        shadowLayer.masksToBounds = false
        layer.masksToBounds = false
        
        layer.insertSublayer(shadowLayer, at: 0)
    }
}
