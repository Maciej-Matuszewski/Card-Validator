//
//  MMGenerator.swift
//  Card Validator
//
//  Created by Maciej Matuszewski on 27.07.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import Foundation

/// Generator for creating Card Numbers based on Luhn algorithm
class MMGenerator: NSObject {
    
    /// Singleton instance of generator
    static public let shared = MMGenerator()
    
    private override init() {}
    
    /// Types of card provider
    ///
    /// - Visa: Visa provider
    /// - MasterCard: MasterCard provider
    /// - Discover: Discover provider
    enum CardProvider: Int{
        case Visa = 0
        case MasterCard = 1
        case Discover = 2
    }
    
    /// Generate of array of random int
    ///
    /// - Parameter lenght: lenght of array
    /// - Returns: array of random int
    internal func generateRandomDigitsArray(lenght: Int) -> [Int]{
        var digits: [Int] = Array<Int>.init(repeating: 0, count: lenght)
        for i in 0..<lenght - 1{
            digits[i] = Int(arc4random_uniform(10))
        }
        return digits
    }
    
    /// Modify array of int according to Luhn Algorithm
    ///
    /// - Parameters:
    ///   - digits: array of int
    ///   - cardProvider: selected card provider (optionaly)
    ///   - masterCardRandomDigit: secound digit for mastercard number
    /// - Returns: array of int generated with Luhn Algorithm
    internal func generateCardNumberDigits(withRandomDigits digits: [Int], cardProvider:CardProvider? = nil, masterCardRandomDigit: Int? = nil) -> [Int]{
        var digits = digits
        var sum = 0;
        var checksum = 0;
        var t = 0;
        var offset = 0;
        var lenght = 0;
        
        switch cardProvider?.rawValue ?? Int(arc4random_uniform(3)) {
        case 0:
            //Visa
            digits[0] = 4
            lenght = 16
            break
        case 1:
            // Mastercard
            digits[0] = 5
            t = masterCardRandomDigit ?? Int(arc4random_uniform(5)) % 5
            digits[1] = 1 + t
            lenght = 16
            break
        case 2:
            // Discover
            digits[0] = 6;
            digits[1] = 0;
            digits[2] = 1;
            digits[3] = 1;
            lenght = 16;
        default:
            fatalError()
        }
        
        offset = (lenght + 1) % 2
        
        for i in 0..<(lenght - 1){
            if (i + offset) % 2 != 0{
                t = digits[i] * 2;
                if (t > 9) {
                    t -= 9
                }
                sum += t
            }else{
                sum += digits[i]
            }
        }
        checksum = (10 - (sum % 10)) % 10
        digits[lenght - 1] = checksum
        
        return digits
    }
    
    /// Transformation of array of digits into string with format XXXX XXXX XXXX XXXX
    ///
    /// - Parameter digits: array of digits
    /// - Returns: string with format XXXX XXXX XXXX XXXX
    internal func generateCardNumber(from digits:[Int]) -> String{
        var output = ""
        for (i, digit) in digits.enumerated(){
            output.append("\(digit)\(i % 4 == 3 && i != digits.count - 1 ? " " : "")")
        }
        return output
    }
    
    /// Generate random card number
    ///
    /// - Parameter cardProvider: selected card provider (optionaly)
    /// - Returns: string with format XXXX XXXX XXXX XXXX
    public func generateCardNumber(cardProvider:CardProvider? = nil) -> String{
        let digits = self.generateRandomDigitsArray(lenght: 16)
        let cardNumbersArray = self.generateCardNumberDigits(withRandomDigits: digits)
        return self.generateCardNumber(from: cardNumbersArray)
    }
}
