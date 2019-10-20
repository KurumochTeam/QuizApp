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
        playMenuButtom.configure(
            title: R.string.localizable.play(),
            image: UIImage(systemName: "gamecontroller.fill"),
            tapAction: presenter?.onPlayPressed
        )
        
        rankingsMenuButton.configure(
            title: R.string.localizable.rankings(),
            image: UIImage(systemName: "rosette"),
            tapAction: presenter?.onRankingsPressed
        )
        
        settingsMenuButton.configure(
            title: R.string.localizable.settings(),
            image: UIImage(systemName: "gear"),
            tapAction: presenter?.onSettingsPressed
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
