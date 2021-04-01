//
//  AppDelegate.swift
//  GhProfile
//
//  Created by Adi Nugroho on 01/04/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = ProfileViewController()
        window?.makeKeyAndVisible()
        return true
    }

}

