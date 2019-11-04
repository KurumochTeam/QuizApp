//
//  View.swift
//  QuizApp
//
//  Created by Aleksandr on 20/10/2019.
//  Copyright © 2019 Kurumoch Team LLC. All rights reserved.
//

protocol Viewable {
    associatedtype Presenter
    
    var presenter: Presenter { get set }
    
    static func instantiate() -> Self
}
