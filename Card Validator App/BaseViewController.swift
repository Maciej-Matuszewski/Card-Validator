//
//  BaseViewController.swift
//  Card Validator
//
//  Created by Maciej Matuszewski on 26.07.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import UIKit

/// Extended UIViewController. Contain simple improvments, that all others conttrollers inherit.
class BaseViewController: UIViewController {

    /// Return preffered _UIStatusBarStyle_ for controller
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /// _BaseViewController_ constructor
    init() {
        super.init(nibName: nil, bundle: nil)
        print("init: \(self)")
    }
    
    /// __UNSUPORTED__ _BaseViewController_ constructor _NSCoder_ parameter
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// _BaseViewController_ deconstructor
    deinit {
        print("deinit: \(self)")
    }
    
    /// Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureLayout()
    }
    
    /// Method for create and add as subview all UI Elements created programically
    func configureLayout(){
        self.view.backgroundColor = UIColor.background
        
    }

}
