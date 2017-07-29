//
//  MainPresenter.swift
//  Netguru Interview App
//
//  Created by Maciej Matuszewski on 26.07.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import Foundation
import UIKit

/// Protocol for view controller, which methods are necessary for __MainPresenter__
protocol MainControllerProtocol: NSObjectProtocol{
    /// Method that should inform user about begining of loading
    func startLoading()
    
    /// Method that should display information user about error occurred
    ///
    /// - Parameter errorMessage: Message for user
    func displayError(errorMessage: String)
    
    /// Method that should inform user about result of validation
    ///
    /// - Parameter valid: result of validation
    func displayStatus(valid: Bool)
    
    /// Method that setup new text for card number field
    ///
    /// - Parameter number: new text for card number field
    func setNewCardNumber(_ number: String)
}

/// Presenter designated for _MainViewController_
class MainPresenter {
    
    /// Controller that conform to _MainControllerProtocol_ attached to presenter
    weak fileprivate var controllerView : MainControllerProtocol?
    
    /// Last model recived from server
    private var currentCardInfoModel: CardInfoModel?
    
    /// _MainPresenter_ constructor
    init(){
        print("init: \(self)")
    }
    
    /// _MainPresenter_ deconstructor
    deinit {
        print("deinit: \(self)")
    }
    
    /// Method that attach controller
    ///
    /// - Parameter controller: Controller that conform to _MainControllerProtocol_
    func attachView(_ controller: MainControllerProtocol){
        self.controllerView = controller
    }
    
    /// Method that detach controller
    func detachView() {
        self.controllerView = nil
    }
    
    /// Method of presenter that request for Card Number Validation
    ///
    /// - Parameter cardNumber: (String) Card Number for validation
    func check(cardNumber: String){
        self.controllerView?.startLoading()
        Network
            .validate(number: cardNumber)
            .sendRequest(
                successCompletion: {[weak self] (model:CardInfoModel) in
                    self?.currentCardInfoModel = model
                    self?.controllerView?.displayStatus(
                        valid: model.valid ?? false
                    )
                }
            ) {[weak self] (errorCode) in
                if errorCode >= 1011 && errorCode <= 1021{
                    self?.controllerView?.displayStatus(valid: false)
                }else{
                    self?.controllerView?.displayError(errorMessage: ErrorHandler.handleError(code: errorCode))
                }
        }
    }
    
    /// Method of presenter that request for Generate Card Number
    func generateCardNumber(){
        let newNumber = MMGenerator.shared.generateCardNumber()
        self.controllerView?.setNewCardNumber(newNumber)
        self.check(cardNumber: newNumber.replacingOccurrences(of: " ", with: ""))
        
    }
}
