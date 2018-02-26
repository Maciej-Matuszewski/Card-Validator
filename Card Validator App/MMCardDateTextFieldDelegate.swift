//
//  MMCardDateTextFieldDelegate.swift
//  Card Validator
//
//  Created by Maciej Matuszewski on 27.07.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import UIKit

class MMCardDateTextFieldDelegate: NSObject{}

extension MMCardDateTextFieldDelegate: MMTextFieldDelegate {
    
    func mmTextField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard
            let text = textField.text
            else{
                return true
        }
        
        let textAfterUpdate = (text as NSString).replacingCharacters(in: range, with: string)
        
        if textAfterUpdate.count >= 6{
            return false
        }
        
        return true
    }
    
    func mmTextFieldValueChanged(_ textField: UITextField){
        guard
            let text = textField.text
        else{
            return
        }
        
        let cursorPosition = textField.selectedTextRange?.end ?? textField.endOfDocument

        let offset = textField.offset(from: textField.beginningOfDocument, to: cursorPosition)

        let cursorOffset = offset == 3 ? 1 : 0
        let temp = text.replacingOccurrences(of: "/", with: "")
        
        if temp.count > 2{
            var output = ""
            for (i, letter) in temp.enumerated(){
                if i == 2{
                    output.append("/")
                }
                output.append(letter)
            }
            textField.text = output
        }else{
            textField.text = temp
        }
        
        let cursorNewPosition = textField.position(
            from: cursorPosition,
            offset: cursorOffset
        ) ?? textField.endOfDocument
    
        textField.selectedTextRange = textField.textRange(
            from: cursorNewPosition,
            to: cursorNewPosition
        )
    }
    
    
    func mmTextFieldShouldActiveNextResponder(_ textField: UITextField, onChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        guard
            let text = textField.text
            else{
                return true
        }
        
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b") == -92
        
        return text.count == 5 && !isBackSpace
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
