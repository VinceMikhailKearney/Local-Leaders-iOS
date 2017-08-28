//
//  AppDelegate.swift
//  LocalLeaders
//
//  Created by Vince Kearney on 08/11/2016.
//  Copyright © 2016 MAV. All rights reserved.
//

import UIKit
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // First thing we need to do if to check for any database migrations that might need performed.
        BaseRealmObject.checkForRealmMigration()

        // Request the MLA JSON from the server.
        LocalLeadersAPI.getMlasJSON()

        // Let's set up the ThemeManager
        do {
            try ThemeManager.initialise()
        } catch themeError.themeFileNotFound {
            print("Seem's we did not find the ThemeManager plist")
        } catch {
            print("Some other error was thrown")
        }

        UIView.appearance(whenContainedInInstancesOf: [UITabBar.self]).tintColor = UIColor(white: 1.0, alpha: 0.3)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(white: 1.0, alpha: 1.0)], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(white: 1.0, alpha: 0.8)], for: .normal)
        UIApplication.shared.statusBarStyle = .lightContent

        return true
    }

    func applicationWillResignActive(_: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

