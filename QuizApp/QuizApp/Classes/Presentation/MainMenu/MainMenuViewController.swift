//
//  MainMenuViewController.swift
//  QuizApp
//
//  Created by Денис on 29.09.2019.
//  Copyright © 2019 Kurumoch Team LLC. All rights reserved.
//

import UIKit

final class MainMenuViewController: UIViewController {
    @IBOutlet private var playMenuButtom: MenuButton!
    @IBOutlet private var rankingsMenuButton: MenuButton!
    @IBOutlet private var settingsMenuButton: MenuButton!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var buttonsStackView: UIStackView!
    
    private var backgroundLayer: CALayer!
    
    lazy var presenter: MainMenuPresenter = deferred()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureBackground()
        configureTitle()
    }
    
    private func configureButtons() {
        playMenuButtom.configure(
            title: R.string.localizable.play(),
            image: UIImage(systemName: "gamecontroller.fill"),
            tapAction: presenter.onPlayPressed
        )
        
        rankingsMenuButton.configure(
            title: R.string.localizable.rankings(),
            image: UIImage(systemName: "rosette"),
            tapAction: presenter.onRankingsPressed
        )
        
        settingsMenuButton.configure(
            title: R.string.localizable.settings(),
            image: UIImage(systemName: "gear"),
            tapAction: presenter.onSettingsPressed
        )
    }
}

extension MainMenuViewController: Viewable {
    static func instantiate() -> MainMenuViewController {
        return R.storyboard.mainMenu().instantiateViewController(
            withIdentifier: String(describing: MainMenuViewController.self)
        ) as! MainMenuViewController
    }
}

private extension MainMenuViewController {
    struct LayerConstants {
        static let backgroundRotation = 0.42 * CGFloat.pi
        static let additionalOffset = CGFloat(-40)
    }
    
    func configureBackground() {
        if backgroundLayer == nil {
            backgroundLayer = CALayer()
            backgroundLayer.backgroundColor = R.color.violetSecondary()?.cgColor
            view.layer.insertSublayer(backgroundLayer, at: 0)
        }
        
        let backgroundYOffset = buttonsStackView.center.y - view.center.y
        
        backgroundLayer.frame = CGRect(
            x: 0,
            y: backgroundYOffset + LayerConstants.additionalOffset,
            width: buttonsStackView.frame.height + backgroundYOffset,
            height: view.frame.height
        )
        
        backgroundLayer.setAffineTransform(
            CGAffineTransform(rotationAngle: LayerConstants.backgroundRotation)
        )
    }
    
    func configureTitle() {
        titleLabel.frame = CGRect(
            x: buttonsStackView.frame.origin.x,
            y: buttonsStackView.frame.origin.y
                - titleLabel.frame.height + LayerConstants.additionalOffset,
            width: titleLabel.frame.width,
            height: titleLabel.frame.height
        )
        
        titleLabel.layer.setAffineTransform(
            CGAffineTransform(rotationAngle: LayerConstants.backgroundRotation - CGFloat.pi / 2)
        )
    }
}

extension MainMenuViewController: MainMenuView {
    func showGameTypes() {
        // TODO: Implement in task-1
    }
    
    func hideGameTypes() {
        // TODO: Implement in task-1
    }
}

protocol MainMenuView {
    func showGameTypes()
    func hideGameTypes()
}
