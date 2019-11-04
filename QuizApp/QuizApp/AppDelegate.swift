//
//  AppDelegate.swift
//  QuizApp
//
//  Created by Денис on 29.09.2019.
//  Copyright © 2019 Kurumoch Team LLC. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    lazy var mainMenuCoordinator: MainMenuCoordinator = deferred()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        
        mainMenuCoordinator = MainMenuCoordinator(navigationController: navigationController)
        mainMenuCoordinator.start()
        
        window?.makeKeyAndVisible()
        
        return true
    }
}
