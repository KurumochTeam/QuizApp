//
//  MainMenuCoordinator.swift
//  QuizApp
//
//  Created by Aleksandr on 20/10/2019.
//  Copyright © 2019 Kurumoch Team LLC. All rights reserved.
//

import UIKit

class MainMenuCoordinator: Coordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMainMenu()
    }
}

private extension MainMenuCoordinator {
    func showMainMenu() {
        let vc = BasicFactory.createScreen(
            viewType: MainMenuViewController.self,
            presenterType: MainMenuDefaultPresenter.self,
            dependecy: ()
        )
        
        navigationController.setViewControllers([vc], animated: false)
    }
    
    func startGameOnLives() {
        // start GameCoordinator
    }
    
    func startGameOnTime() {
        // start GameCoordinator
    }
    
    func showSettings() {
        // assemble and show settings
    }
    
    func showRankings() {
        // assemble and show rankings
    }
}

protocol MainMenuActions {
    var onStartGameOnLives: () -> () { get set }
    var onStartGameOnTime: () -> () { get set }
    var onShowSettings: () -> () { get set }
    var onShowRankings: () -> () { get set }
}
