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
    
    var presenter: MainMenuPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButtons()
    }
    
    private func configureButtons() {
        playMenuButtom.configure(with: "Play".localized, and: .play)
        rankingsMenuButton.configure(with: "Rankings".localized, and: .rankings)
        settingsMenuButton.configure(with: "Settings".localized, and: .settings)
        
        let presenter = self.presenter
        playMenuButtom.onTapAction = { presenter?.onPlayPressed() }
        rankingsMenuButton.onTapAction = { presenter?.onRankingsPressed() }
        settingsMenuButton.onTapAction = { presenter?.onSettingsPressed() }
    }
}

extension MainMenuViewController: MainMenuView {
    func showGameTypes() {
        // todo
    }
    
    func hideGameTypes() {
        // todo
    }
}

protocol MainMenuView {
    func showGameTypes()
    func hideGameTypes()
}
