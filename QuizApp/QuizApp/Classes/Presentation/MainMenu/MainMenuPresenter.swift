//
//  MainMenuViewModel.swift
//  QuizApp
//
//  Created by Денис on 29.09.2019.
//  Copyright © 2019 Kurumoch Team LLC. All rights reserved.
//

import Foundation

class MainMenuDefaultPresenter{}

protocol MainMenuPresenter {
    func onPlayPressed()
    func onStartOnLivesGamePressed()
    func onStartOnTimeGamePressed()
    func onRankingsPressed()
    func onSettingsPressed()
}
