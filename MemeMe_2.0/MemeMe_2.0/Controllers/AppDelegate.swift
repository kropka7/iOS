//
//  AppDelegate.swift
//  MemeMe_2.0
//
//  Created by marta on 21/03/2020.
//  Copyright © 2020 udacity.com. All rights reserved.
//

import UIKit
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var memes = [Meme]()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}
