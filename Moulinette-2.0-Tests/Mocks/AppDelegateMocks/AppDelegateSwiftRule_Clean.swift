/**
//
//  AppDelegate.swift
//  HSN
//
//  Created by Jonathan Samudio on 3/3/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let appTools = AppTools()
    
    let appAppearances = AppAppearances()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        appTools.setupTools(launchOptions: launchOptions)
        appAppearances.setup()
        setupRootViewController()
        return true
    }
    
    private func setupRootViewController() {
        window = UIWindow()
        let viewController: RootTabBarController = RootTabBarController.initFromStoryboard(dependencies: AppDependencies.shared)
        RootWindowVCInjector.set(viewController: viewController, to: window)
    }
}
**/
