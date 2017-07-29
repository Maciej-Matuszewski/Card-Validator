//
//  AppDelegate.swift
//  Netguru Interview App
//
//  Created by Maciej Matuszewski on 26.07.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import UIKit

@UIApplicationMain
/// System class for handle application states
class AppDelegate: UIResponder, UIApplicationDelegate {

    ///Main window in application
    var window: UIWindow?

    /// Method called when app did finish launch
    ///
    /// - Parameters:
    ///   - application: singleton app object
    ///   - launchOptions: A dictionary indicating the reason the app was launched (if any).
    /// - Returns: false if the app cannot handle the URL resource or continue a user activity, otherwise return true. The return value is ignored if the app is launched as a result of a remote notification.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FlowManager.shared.loadInitialController()
        return true
    }
}

