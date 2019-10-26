//
//  MainMenuCoordinator.swift
//  QuizApp
//
//  Created by Aleksandr on 20/10/2019.
//  Copyright © 2019 Kurumoch Team LLC. All rights reserved.
//

import UIKit

class MainMenuCoordinator: Coordinator {
    private let transitionHandler: UINavigationController
    
    init(transitionHandler: UINavigationController) {
        self.transitionHandler = transitionHandler
    }
    
    func start() {
        showMainMenu()
    }
    
    private func showMainMenu() {
        let vc = BasicFactory.createScreen(
            viewType: MainMenuViewController.self,
            presenterType: MainMenuDefaultPresenter.self,
            dependecy: ()
        )
        
        transitionHandler.setViewControllers([vc], animated: false)
    }
    
    private func startGameOnLives() {
        // start GameCoordinator
    }
    
    private func startGameOnTime() {
        // start GameCoordinator
    }
    
    private func showSettings() {
        // assemble and show settings
    }
    
    private func showRankings() {
        // assemble and show rankings
    }
}

protocol MainMenuOutput {
    var onStartGameOnLives: () -> () { get set }
    var onStartGameOnTime: () -> () { get set }
    var onShowSettings: () -> () { get set }
    var onShowRankings: () -> () { get set }
}
