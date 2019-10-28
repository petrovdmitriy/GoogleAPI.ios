//
//  AppDelegate.swift
//  GoogleAPI
//
//  Created by Dmitriy Petrov on 17/10/2019.
//  Copyright © 2019 BytePace. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private let id = "453999149277-hg97ils5re9m581naqf6ic8ihnjm6r9k.apps.googleusercontent.com"
    private let testID = "224113705927-5jvh1cpjoe3gbvadpnlbhoffchdimd3t.apps.googleusercontent.com"
    private let googleService = GoogleService()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        googleService.setClientID(withID: id)
        
        setWindow()
        
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return googleService.handle(url: url)
    }
    
    private func setWindow() {
        window = UIWindow()
        window?.rootViewController = getRootViewController()
        window?.makeKeyAndVisible()
    }
    
    private func getRootViewController() -> UIViewController {
        return SignInViewController.initFromNib()
    }
}
