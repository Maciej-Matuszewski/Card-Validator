//
//  MainViewController.swift
//  Netguru Interview App
//
//  Created by Maciej Matuszewski on 26.07.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import UIKit

/// Main controller of application
class MainViewController: BaseViewController {
    
    /// Presenter attached to controller
    fileprivate let presenter: MainPresenter

    /// Custom field for card number
    fileprivate let cardNumberField = MMTextField.init(
        placeholder: "CARD NUMBER".localized,
        pattern: Constants.Paterns.CardNumber,
        keyboardType: UIKeyboardType.numberPad,
        delegate: MMCardNumberTextFieldDelegate()
    )
    
    /// Custom field for card valid date
    private let cardDateField = MMTextField.init(
        placeholder: "MM/YY",
        pattern: Constants.Paterns.CardDate,
        keyboardType: UIKeyboardType.numberPad,
        delegate: MMCardDateTextFieldDelegate()
    )
    
    /// Custom field for card CVC code
    private let cardCVCField = MMTextField.init(
        placeholder: "CVC",
        pattern: Constants.Paterns.CardCVC,
        keyboardType: UIKeyboardType.numberPad,
        delegate: MMCardCVCTextFieldDelegate()
    )
    
    /// Indicator that inform about card validity state
    /// ## States:
    /// - loading: Waiting for server response
    /// - success: Card is valid
    /// - failure: Card is invalid
    /// - hidden: Idle state
    internal let statusIndicator = MMStatusIndicator.init()
    
    /// MainViewController constructor
    ///
    /// - Parameter presenter: Presenter that privide data for controller
    init(presenter: MainPresenter) {
        self.presenter = presenter
        super.init()
    }
    
    /// __UNSUPORTED__ _MainViewController_ constructor _NSCoder_ parameter
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.attachView(self)
    }
    
    /// Method for create and add as subview all UI Elements created programically
    override func configureLayout() {
        super.configureLayout()
        
        self.navigationItem.title = "Netguru Interview App"
        
        self.view.addGestureRecognizer(
            UITapGestureRecognizer.init(target: self.view, action: #selector(self.view.endEditing(_:)))
        )
        
        self.cardNumberField.accessibilityIdentifier = "CARD_NUMBER_FIELD"
        self.cardNumberField.setNextResponder(nextField: self.cardDateField)
        self.cardNumberField.onChangeValueFunction = {[weak self] in
            self?.statusIndicator.setState(.hidden)
        }
        self.view.addSubview(self.cardNumberField)
        self.cardNumberField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.cardNumberField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        self.cardNumberField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 48).isActive = true
        
        self.statusIndicator.accessibilityIdentifier = "STATUS_INDICATOR"
        self.cardNumberField.addSubview(self.statusIndicator)
        self.statusIndicator.rightAnchor.constraint(equalTo: self.cardNumberField.rightAnchor).isActive = true
        self.statusIndicator.centerYAnchor.constraint(equalTo: self.cardNumberField.centerYAnchor).isActive = true
        
        
        self.cardDateField.accessibilityIdentifier = "CARD_DATE_FIELD"
        self.cardDateField.setPreviousResponder(previousField: self.cardNumberField)
        self.cardDateField.setNextResponder(nextField: self.cardCVCField)
        self.view.addSubview(self.cardDateField)
        self.cardDateField.topAnchor.constraint(equalTo: self.cardNumberField.bottomAnchor, constant: 12).isActive = true
        self.cardDateField.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -6).isActive = true
        self.cardDateField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4, constant: -6).isActive = true
        
        self.cardCVCField.accessibilityIdentifier = "CARD_CVC_FIELD"
        self.cardCVCField.setPreviousResponder(previousField: self.cardDateField)
        self.view.addSubview(self.cardCVCField)
        self.cardCVCField.topAnchor.constraint(equalTo: self.cardNumberField.bottomAnchor, constant: 12).isActive = true
        self.cardCVCField.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 6).isActive = true
        self.cardCVCField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4, constant: -6).isActive = true
        
        let validateButton = MMButton.init(title: "Validate".localized) {[weak self] in
            self?.validate()
        }
        
        self.view.addSubview(validateButton)
        validateButton.topAnchor.constraint(equalTo: self.cardCVCField.bottomAnchor, constant: 12).isActive = true
        validateButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        let generateButton = MMButton.init(title: "Generate".localized) {[weak self] in
            self?.presenter.generateCardNumber()
        }
        
        self.view.addSubview(generateButton)
        generateButton.topAnchor.constraint(equalTo: validateButton.bottomAnchor, constant: 12).isActive = true
        generateButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    /// Method called on __Validate button__ touch up inside
    private func validate(){
        if !self.cardDateField.isValid(){
            self.cardDateField.setAs(valid: false)
        }
        if !self.cardCVCField.isValid(){
            self.cardCVCField.setAs(valid: false)
        }
        
        if self.cardNumberField.isValid(){
            self.presenter.check(cardNumber: self.cardNumberField.text.replacingOccurrences(of: " ", with: ""))
        }else{
            self.cardNumberField.setAs(valid: false)
        }
    }
}

extension MainViewController: MainControllerProtocol{
    
    func startLoading(){
        self.statusIndicator.setState(.loading)
    }
    
    func displayError(errorMessage: String){
        self.statusIndicator.setState(.hidden)
        let alertController = UIAlertController.init(
            title: "Error".localized,
            message: errorMessage,
            preferredStyle: UIAlertControllerStyle.alert
        )
        alertController.addAction(
            UIAlertAction.init(
                title: "OK".localized,
                style: UIAlertActionStyle.default,
                handler: nil
            )
        )
        self.present(alertController, animated: true, completion: nil)
    }
    
    func displayStatus(valid: Bool){
        self.statusIndicator.setState(valid ? .success : .failure)
    }
    
    func setNewCardNumber(_ number: String){
        self.cardNumberField.setAs(valid: true)
        self.cardNumberField.textField.text = number
    }
}
