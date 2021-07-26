//
//  AppDelegate.swift
//  WTestPostalModule
//
//  Created by Jefferson Batista on 07/24/2021.
//  Copyright (c) 2021 Jefferson Batista. All rights reserved.
//

import UIKit
import WTestPostalModule

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let controller = Router.rootViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.tintColor = .gray
        
        UINavigationBar.appearance().largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor:UIColor.white,
             NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 22)]

        window?.rootViewController = navigationController
        return true
    }
}

