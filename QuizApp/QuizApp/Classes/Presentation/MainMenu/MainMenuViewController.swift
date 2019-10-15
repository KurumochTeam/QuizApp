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
        
        playMenuButtom.onTapAction = presenter?.onPlayPressed
        rankingsMenuButton.onTapAction = presenter?.onRankingsPressed
        settingsMenuButton.onTapAction = presenter?.onSettingsPressed
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
