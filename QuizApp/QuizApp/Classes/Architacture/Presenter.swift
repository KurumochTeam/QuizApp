//
//  Presenter.swift
//  QuizApp
//
//  Created by Aleksandr on 24/10/2019.
//  Copyright © 2019 Kurumoch Team LLC. All rights reserved.
//

protocol Presentable {
    associatedtype View
    associatedtype Dependency = Void
    
    var view: View { get }
    var dependency: Dependency { get }
    
    init(view: View, dependency: Dependency)
}
