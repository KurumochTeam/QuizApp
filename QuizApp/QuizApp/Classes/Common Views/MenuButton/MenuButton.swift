//
//  MenuButton.swift
//  QuizApp
//
//  Created by Aleksandr on 05/10/2019.
//  Copyright © 2019 Kurumoch Team LLC. All rights reserved.
//

import UIKit

final class MenuButton: UIView, NibOwnerLoadable {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var delegate: ButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
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
