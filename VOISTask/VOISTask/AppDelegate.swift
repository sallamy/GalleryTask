//
//  AppDelegate.swift
//  VOISTask
//
//  Created by concarsadmin on 12/20/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let bounds = UIScreen.main.bounds
        self.window = UIWindow(frame: bounds)
        self.window?.isHidden = false
        setRootViewController()
        return true
    }
    
    func setRootViewController() {
        self.window?.rootViewController = UINavigationController(rootViewController: GalleryViewController())
    }

}

