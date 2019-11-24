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
    
    private var shadowLayer: CALayer!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowLayer = createShadowLayer(for: layer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addCornerRadius()
        adjust(shadowLayer: shadowLayer, within: layer)
    }
    
    func configure(title: String, image: UIImage?, tapAction: (() -> ())?) {
        self.titleLabel.text = title
        imageView.image = image
        
        onTapAction = tapAction
    }
    
    func setAlphaOfSubviews(_ value: CGFloat) {
        imageView.alpha = value
        titleLabel.alpha = value
    }
    
    @IBAction private func didTapButton(_ sender: UIButton) {
        onTapAction?()
    }
}

private extension MenuButton {
    enum LayerConstants {
        static let relativeWidth = CGFloat(0.83)
    }
    
    func addCornerRadius() {
        containerView.layer.cornerRadius =
            layer.frame.height * LayerConstants.relativeWidth / 2
        layer.cornerRadius = containerView.layer.cornerRadius
        
        containerView.layer.masksToBounds = true
    }
}
