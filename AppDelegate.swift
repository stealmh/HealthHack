//
//  AppDelegate.swift
//  HealthHack
//
//  Created by kimminho on 2022/11/08.
//

import Firebase
import UIKit
import FatSecretSwift
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    enum Constants {
        static let apiKey = "919b701f763c4b2db6641b62fd1b5e49"
        static let apiSecret = "ddb8a0f5b86b41c7b06d8894a1675685"
    }

    var window: UIWindow?

    private func requestNotificationAuthorization(application: UIApplication){

            let center = UNUserNotificationCenter.current()
            let options: UNAuthorizationOptions = [.alert, .badge, .sound]

            center.requestAuthorization(options: options) { granted, error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
    }
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FatSecretCredentials.setConsumerKey(Constants.apiKey)
        FatSecretCredentials.setSharedSecret(Constants.apiSecret)
        requestNotificationAuthorization(application: application)
        FirebaseApp.configure()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }


}

