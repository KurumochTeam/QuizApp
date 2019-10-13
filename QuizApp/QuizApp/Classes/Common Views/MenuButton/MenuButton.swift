//
//  MenuButton.swift
//  QuizApp
//
//  Created by Aleksandr on 05/10/2019.
//  Copyright © 2019 Kurumoch Team LLC. All rights reserved.
//

import UIKit

final class MenuButton: UIView, NibOwnerLoadable {
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var containerView: UIView!
    
    var delegate: ButtonDelegate?
    
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
    
    func configure(with title: String, and image: Image) {
        self.title.text = title
        imageView.image = UIImage(systemName: image.rawValue)
    }
    
    @IBAction func didTapButton(_ sender: UIButton) {
        delegate?.didButtonTap(self)
    }
}

extension MenuButton {
    enum Image: String {
        case play = "gamecontroller.fill"
        case rankings = "rosette" // todo: replace image
        case settings = "gear"
    }
}

protocol ButtonDelegate {
    func didButtonTap(_ button: MenuButton)
}

private extension MenuButton {
    struct LayerConstants {
        static let relativeWidth = CGFloat(0.83)
        static let shadowRadius = CGFloat(40)
    }
    
    func addCornerRadius() {
        containerView.layer.cornerRadius = layer.frame.height * LayerConstants.relativeWidth / 2
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
        shadowLayer.backgroundColor = UIColor.red.cgColor
        shadowLayer.shadowColor = UIColor.violetMain.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0, height: 8)
        shadowLayer.shadowRadius = LayerConstants.shadowRadius
        shadowLayer.masksToBounds = false
        layer.masksToBounds = false
        
        layer.insertSublayer(shadowLayer, at: 0)
    }
}
