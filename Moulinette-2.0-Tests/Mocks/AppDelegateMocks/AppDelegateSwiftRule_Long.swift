/**
//
//  AppDelegate.swift
//  Scotts
//
//  Created by Christopher Jones on 9/3/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import UIKit
import CoreSpotlight
import AppsFlyerLib

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // We don't want to track user for dev builds.
        // TODO: Uncomment those lines when testing AppsFlyer is done.
        setupAppsFlyer()
        
        return Application.run(launchOptions)
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        return Application.currentApplication.handleDeeplinkToUrl(url)
    }
    
    func application(application: UIApplication,
                     openURL url: NSURL,
                     sourceApplication: String?,
                     annotation: AnyObject) -> Bool {
        return Application.currentApplication.handleDeeplinkToUrl(url)
    }
    
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        guard let url = NSURL(string: shortcutItem.type) else {
            return
        }
        
        Application.currentApplication.handleDeeplinkToUrl(url)
    }
    
    func application(application: UIApplication, continueUserActivity userActivity: NSUserActivity, restorationHandler: ([AnyObject]?) -> Void) -> Bool {
        
        if userActivity.activityType == IndexingConstants.domainIdentifier {
            guard let productId = userActivity.userInfo?[IndexingConstants.activityId] as? String,
                let url = NSURL(string: "\(IndexingConstants.activityDeepLink)?productId=\(productId)&isAdding=false") else {
                    return false
            }
            
            Application.currentApplication.handleDeeplinkToUrl(url)
            
        } else if userActivity.activityType == CSSearchableItemActionType,
            let productId = userActivity .userInfo?[CSSearchableItemActivityIdentifier] as? String,
            let url = NSURL(string: "\(IndexingConstants.activityDeepLink)?productId=\(productId)&isAdding=false") {
            Application.currentApplication.handleDeeplinkToUrl(url)
        }
        
        
        return true
    }
}

// MARK: - Setup functions

extension AppDelegate {
    
    func setupAppsFlyer() {
        AppsFlyerTracker.sharedTracker().appsFlyerDevKey = Constants.AppsFlyerConstants.devKey
        #if RELEASE
            AppsFlyerTracker.sharedTracker().appleAppID = Constants.AppsFlyerConstants.appleAppId
        #elseif BUTTER
            AppsFlyerTracker.sharedTracker().appleAppID = Constants.AppsFlyerConstants.appleDevAppId
        #endif
        AppsFlyerTracker.sharedTracker().trackAppLaunch()
    }
    
}
**/
