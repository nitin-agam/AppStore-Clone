//
//  AppDelegate.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 18/11/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let appTabBarController = AppTabBarController()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = appTabBarController
        self.window?.makeKeyAndVisible()
        return true
    }
}
