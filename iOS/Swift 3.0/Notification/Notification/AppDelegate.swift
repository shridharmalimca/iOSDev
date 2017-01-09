//
//  AppDelegate.swift
//  Notification
//
//  Created by Shridhar Mali on 1/9/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        registerNotification()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func registerNotification() {
        
        //Actions
        
        let oKAction = UIMutableUserNotificationAction()
        oKAction.title = "Ok"
        oKAction.identifier = "Ok"
        oKAction.isDestructive = false
        oKAction.activationMode = .background
        oKAction.isAuthenticationRequired = false
        oKAction.behavior = .default
        
        let cancelAction = UIMutableUserNotificationAction()
        cancelAction.title = "Cancel"
        cancelAction.identifier = "Cancel"
        cancelAction.isDestructive = true
        cancelAction.activationMode = .background
        cancelAction.isAuthenticationRequired = false
        cancelAction.behavior = .default
        
        //Category 
        let category = UIMutableUserNotificationCategory()
        category.identifier = "localNotification"
        category.setActions([oKAction,cancelAction], for: .default)
        
        let categories: Set<UIUserNotificationCategory> = [category]
        
        let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: categories)
        UIApplication.shared.registerUserNotificationSettings(settings)
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
        if identifier == "Ok" {
            print("Ok Button clicked")
            
        } else if identifier == "Cancel" {
            print("Cancel Button Clicked")
        }
        completionHandler()
    }
}

