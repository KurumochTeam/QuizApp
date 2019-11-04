//
//  MainMenuViewModel.swift
//  QuizApp
//
//  Created by Денис on 29.09.2019.
//  Copyright © 2019 Kurumoch Team LLC. All rights reserved.
//

import Foundation

final class MainMenuDefaultPresenter: MainMenuPresenter, Presentable {
    let dependency: Void
    let view: MainMenuView
    
    init(view: MainMenuView, dependency: ()) {
        self.view = view
        self.dependency = dependency
    }
    
    func onPlayPressed() {
        view.showGameTypes()
    }
    
    func onStartOnLivesGamePressed() {
        
    }
    
    func onStartOnTimeGamePressed() {
        
    }
    
    func onRankingsPressed() {
        
    }
    
    func onSettingsPressed() {
        
    }
}

protocol MainMenuPresenter {
    func onPlayPressed()
    func onStartOnLivesGamePressed()
    func onStartOnTimeGamePressed()
    func onRankingsPressed()
    func onSettingsPressed()
}
