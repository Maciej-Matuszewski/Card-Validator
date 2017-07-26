//
//  FlowMenager.swift
//  Netguru Interview App
//
//  Created by Maciej Matuszewski on 26.07.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import UIKit

class FlowManager {
    
    static public let shared = FlowManager()
    private let navigationController: UINavigationController
    
    private init() {
        self.navigationController = UINavigationController.init()
        self.navigationController.navigationBar.barTintColor = UIColor.main
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else {
                fatalError()
        }
        appDelegate.window = UIWindow.init(frame: UIScreen.main.bounds)
        appDelegate.window?.rootViewController = self.navigationController
        appDelegate.window?.makeKeyAndVisible()
    }
    
    
    public func loadInitialController(){
        self.loadMainController()
    }
    
    private func loadMainController(animated: Bool = false){
        let viewController = UIViewController()
        self.navigationController.setViewControllers([viewController], animated: animated)
    }
}
