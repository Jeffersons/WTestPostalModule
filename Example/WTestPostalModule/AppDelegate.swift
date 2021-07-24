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

        window?.rootViewController = controller
        return true
    }
}

