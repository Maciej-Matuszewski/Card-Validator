//
//  MMCardCVCTextFieldDelegate.swift
//  Card Validator
//
//  Created by Maciej Matuszewski on 27.07.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import UIKit

class MMCardCVCTextFieldDelegate: NSObject{}

extension MMCardCVCTextFieldDelegate: MMTextFieldDelegate {
    
    func mmTextField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard
            let text = textField.text
            else{
                return true
        }
        
        let textAfterUpdate = (text as NSString).replacingCharacters(in: range, with: string)
        
        if textAfterUpdate.count >= 4{
            return false
        }
        
        return true
    }
    
    func mmTextFieldValueChanged(_ textField: UITextField){}
    
    
    func mmTextFieldShouldActiveNextResponder(_ textField: UITextField, onChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        guard
            let text = textField.text
            else{
                return true
        }
        
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b") == -92
        
        return text.count == 3 && !isBackSpace
    }
    
    func mmTextFieldShouldActivePreviousResponder(_ textField: UITextField, onChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        guard
            let text = textField.text
            else{
                return true
        }
        
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b") == -92
        
        return text.count == 0 && isBackSpace
    }
}
