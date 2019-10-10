//
//  MainMenuViewController.swift
//  QuizApp
//
//  Created by Денис on 29.09.2019.
//  Copyright © 2019 Kurumoch Team LLC. All rights reserved.
//

import UIKit

final class MainMenuViewController: UIViewController {
    @IBOutlet private weak var playMenuButtom: MenuButton!
    @IBOutlet private weak var rankingsMenuButton: MenuButton!
    @IBOutlet private weak var settingsMenuButton: MenuButton!
    
    var presenter: MainMenuPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButtons()
    }
    
    private func configureButtons() {
        playMenuButtom.configure(with: "Play", and: .play)
        rankingsMenuButton.configure(with: "Rankings", and: .rankings)
        settingsMenuButton.configure(with: "Settings", and: .settings)
        
        playMenuButtom.delegate = self
        rankingsMenuButton.delegate = self
        settingsMenuButton.delegate = self
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

extension MainMenuViewController: ButtonDelegate {
    func didButtonTap(_ button: MenuButton) {
        if button == playMenuButtom {
            presenter?.onStartPressed()
        }
        
        if button == rankingsMenuButton {
            presenter?.onRankingsPressed()
        }
        
        if button == settingsMenuButton {
            presenter?.onSettingsPressed() 
        }
    }
}

protocol MainMenuView {
    func showGameTypes()
    func hideGameTypes()
}
