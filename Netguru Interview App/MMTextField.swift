//
//  MMTextField.swift
//  Netguru Interview App
//
//  Created by Maciej Matuszewski on 26.07.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import UIKit

/// Custom UI Element for text, that contain UITextField
class MMTextField: UIView {

    /// Main element of _MMTextField_
    public let textField = UITextField.init()
    
    /// Delegate of _MMTextField_
    public let delegate: MMTextFieldDelegate
    
    /// Field that should takeover focus if current field is full
    fileprivate weak var nextField: MMTextField?
    
    /// Field that should takeover focus if current field is empty and user will try to delete
    fileprivate weak var previousField: MMTextField?
    
    /// Regular expression that validate text in field
    fileprivate let pattern: String
    
    
    /// Callback method that is executed on textField's text change
    public var onChangeValueFunction : (() -> Void)?
    
    /// _MMTextField_ constructor
    ///
    /// - Parameters:
    ///   - placeholder: hint text that is visible if texfield is empty
    ///   - pattern: Regular expression that validate text in field
    ///   - keyboardType: type of keyboard
    ///   - delegate: Object that conform to MMTextFieldDelegate
    init(
        placeholder: String,
        pattern: String,
        keyboardType: UIKeyboardType = .default,
        delegate: MMTextFieldDelegate
    ) {
        self.delegate = delegate
        self.pattern = pattern
        super.init(frame: CGRect.zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.layer.borderColor = UIColor.text.cgColor
        self.layer.borderWidth = Constants.Values.BorderWidth
        self.layer.cornerRadius = Constants.Values.CornerRadius
        self.backgroundColor = UIColor.white
        
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.textField.textColor = UIColor.text
        self.textField.font = UIFont.big
        self.textField.placeholder = placeholder
        self.textField.textAlignment = .left
        self.textField.keyboardType = keyboardType
        self.textField.autocorrectionType = .no
        self.textField.autocapitalizationType = .none
        
        self.textField.delegate = self
        self.textField.addTarget(self, action: #selector(self.textFieldValueChanged(_:)), for: UIControlEvents.editingChanged)
        self.textField.addTarget(self, action: #selector(self.textFieldOnEndEdit(_:)), for: UIControlEvents.editingDidEnd)
        
        self.addSubview(self.textField)
        
        self.textField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.textField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        self.textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Asks UIKit to make this object the first responder in its window.
    ///
    /// - Returns: true if this object is now the first-responder or false if it is not.
    override func becomeFirstResponder() -> Bool {
        return self.textField.becomeFirstResponder()
    }
    
    /// Append text to text that is currently in field
    ///
    /// - Parameter text: text to append
    func appendText(_ text:String){
        self.textField.text = self.textField.text?.appending(text)
    }
    
    /// Remove last character from text that is currently in field
    func removeLastCharacter(){
        var text = self.textField.text ?? ""
        text.characters = text.characters.dropLast()
        self.textField.text = text
    }
    
    
    /// Setup next field that should take focus
    ///
    /// - Parameter nextField: next field
    func setNextResponder(nextField: MMTextField){
        self.textField.addTarget(nextField, action: #selector(nextField.becomeFirstResponder), for: UIControlEvents.editingDidEndOnExit)
        self.nextField = nextField
    }
    
    /// Setup previous field that should take focus
    ///
    /// - Parameter previousField: previous field
    func setPreviousResponder(previousField: MMTextField){
        self.previousField = previousField
    }
    
    /// return value that is currently stored in text field
    var text: String {
        return self.textField.text ?? ""
    }
    
    /// Check that text stored in text field is valid with delivered regular expression
    ///
    /// - Returns: result that text is valid
    func isValid() -> Bool{
        
        guard
            let text = self.textField.text
            else {
                return false
        }
        return text.isValid(withPattern: self.pattern)
    }
    
    /// Setup visual parameters that inform user about validate state
    ///
    /// - Parameter valid: __Bool__ value that text in field is valid
    func setAs(valid:Bool){
        self.layer.borderColor = valid ? UIColor.text.cgColor : UIColor.red.cgColor
        self.textField.textColor = valid ? UIColor.text : UIColor.red
    }
}

extension MMTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if self.delegate.mmTextFieldShouldActiveNextResponder(textField, onChangeCharactersIn: range, replacementString: string){
            
            if let nextField = self.nextField{
                _ = nextField.becomeFirstResponder()
                nextField.appendText(string)
            }else{
                self.textField.resignFirstResponder()
            }
            return false
        }
        
        return self.delegate.mmTextField(textField, shouldChangeCharactersIn:range, replacementString:string)
    }
    
    func textFieldValueChanged(_ textField: UITextField){
        self.setAs(valid: true)
        self.delegate.mmTextFieldValueChanged(textField)
        guard let function = self.onChangeValueFunction else {
            return
        }
        function()
    }
    
    func keyboardInputShouldDelete(_ textField: UITextField) -> Bool {
        if textField.text?.characters.isEmpty ?? false{
            _ = self.previousField?.becomeFirstResponder()
            self.previousField?.removeLastCharacter()
            return false
        }
        return true
    }
    
    func textFieldOnEndEdit(_ sender: UITextField){
        self.setAs(valid: self.isValid())
    }
    
}

/// Delegate Protocol for text formating and recognize that MMTextField should pass focus to other elements
protocol MMTextFieldDelegate: NSObjectProtocol{
    
    /// Asks the delegate if the specified text should be changed.
    ///
    /// - Parameters:
    ///   - textField: The text field containing the text.
    ///   - range: The range of characters to be replaced.
    ///   - string: The replacement string for the specified range.
    /// - Returns: true if the specified text range should be replaced; otherwise, false to keep the old text.
    func mmTextField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    
    
    /// Inform delegate that text has changed
    ///
    /// - Parameter textField: The text field containing the text
    func mmTextFieldValueChanged(_ textField: UITextField)
    
    /// Asks the delegate if the specified text should be passed to next field.
    ///
    /// - Parameters:
    ///   - textField: The text field containing the text.
    ///   - range: The range of characters to be replaced.
    ///   - string: The replacement string for the specified range.
    /// - Returns: true if the specified text range should be passed.
    func mmTextFieldShouldActiveNextResponder(_ textField: UITextField, onChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    
    /// Asks the delegate if the specified text should be passed to next previous.
    ///
    /// - Parameters:
    ///   - textField: The text field containing the text.
    ///   - range: The range of characters to be replaced.
    ///   - string: The replacement string for the specified range.
    /// - Returns: true if the specified text range should be passed.
    func mmTextFieldShouldActivePreviousResponder(_ textField: UITextField, onChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
}
