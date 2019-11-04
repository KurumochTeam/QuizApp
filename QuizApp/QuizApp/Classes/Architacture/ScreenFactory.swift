//
//  ScreenFactory.swift
//  QuizApp
//
//  Created by Aleksandr on 26/10/2019.
//  Copyright © 2019 Kurumoch Team LLC. All rights reserved.
//

import UIKit

final class BasicFactory{
    private init() { }
    
    static func createScreen<View: Viewable, Presenter: Presentable>(
        viewType: View.Type,
        presenterType: Presenter.Type,
        dependecy: Presenter.Dependency
    ) -> UIViewController {
        var view = View.instantiate()
        let presenter = Presenter.init(
            view: view as! Presenter.View,
            dependency: dependecy
        )
        
        view.presenter = presenter as! View.Presenter

        return view as! UIViewController
    }
}
