//
//  FlowMenager.swift
//  Card Validator
//
//  Created by Maciej Matuszewski on 26.07.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import UIKit
import IQKeyboardManager

/// Class for manage active controllers and configure flow elements
class FlowManager {
    
    /// Singleton instance of _FlowManager_
    static public let shared = FlowManager()
    
    /// Main navigation controller in application. Base of _FlowManager_.
    private let navigationController: UINavigationController
    
    /// _FlowManager_ constructor
    private init() {
        
        self.navigationController = UINavigationController.init()
        self.navigationController.navigationBar.barTintColor = UIColor.main
        self.navigationController.navigationBar.isTranslucent = false
        self.navigationController.navigationBar.tintColor = UIColor.white
        self.navigationController.navigationBar.barStyle = UIBarStyle.black
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                fatalError()
        }
        appDelegate.window = UIWindow.init(frame: UIScreen.main.bounds)
        appDelegate.window?.rootViewController = self.navigationController
        appDelegate.window?.makeKeyAndVisible()
    }
    
    
    /// _FlowManager_ method responsible for select and display initial controller
    public func loadInitialController(){
        self.loadMainController()
    }
    
    /// _FlowManager_ method responsible for display main controller of application
    ///
    /// - Parameter animated: __Bool__ value that controller change should have animation
    private func loadMainController(animated: Bool = false){
        
        let presenter = MainPresenter()
        let viewController = MainViewController.init(presenter: presenter)
        self.navigationController.setViewControllers([viewController], animated: animated)
    }
    
    /// Method for set view controller in main navigation controller
    ///
    /// - Parameters:
    ///   - controller: view controller for present
    ///   - animated: __Bool__ value that controller change should have animation
    public func present(controller: BaseViewController, animated: Bool = false){
        self.navigationController.setViewControllers([controller], animated: animated)
    }
}
