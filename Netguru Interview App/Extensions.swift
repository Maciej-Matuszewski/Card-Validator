//
//  Extensions.swift
//  Netguru Interview App
//
//  Created by Maciej Matuszewski on 26.07.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func isValid(withPattern pattern: String) -> Bool {
        do{
            let regEx = try NSRegularExpression.init(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let regExMaches = regEx.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSRange.init(location: 0, length: self.characters.count))
            if(regExMaches > 0){return true}
        }catch _{
            return false
        }
        
        return false
    }
}

extension UIFont {
    static let normal = UIFont.init(name: "TitilliumWeb-Regular", size: UIFont.systemFontSize - 1) ?? UIFont.systemFont(ofSize: UIFont.systemFontSize - 1)
    static let normalBold = UIFont.init(name: "TitilliumWeb-Bold", size: UIFont.systemFontSize - 1) ?? UIFont.systemFont(ofSize: UIFont.systemFontSize - 1, weight: 12)
    static let medium = UIFont.init(name: "TitilliumWeb-Regular", size: UIFont.systemFontSize + 1) ?? UIFont.systemFont(ofSize: UIFont.systemFontSize + 1)
    static let mediumBold = UIFont.init(name: "TitilliumWeb-Bold", size: UIFont.systemFontSize + 1) ?? UIFont.systemFont(ofSize: UIFont.systemFontSize + 1, weight: 12)
    static let small = UIFont.init(name: "TitilliumWeb-Regular", size: UIFont.systemFontSize - 3) ?? UIFont.systemFont(ofSize: UIFont.systemFontSize - 3)
    static let smallBold = UIFont.init(name: "TitilliumWeb-Bold", size: UIFont.systemFontSize - 3) ?? UIFont.systemFont(ofSize: UIFont.systemFontSize - 3, weight: 12)
    static let big = UIFont.init(name: "TitilliumWeb-Light", size: UIFont.systemFontSize + 5) ?? UIFont.systemFont(ofSize: UIFont.systemFontSize + 5)
    static let bigBold = UIFont.init(name: "TitilliumWeb-SemiBold", size: UIFont.systemFontSize + 5) ?? UIFont.boldSystemFont(ofSize: UIFont.systemFontSize + 5)
}

extension UIColor {
    
    static let main = UIColor(red:0.24, green:0.80, blue:0.58, alpha:1.00)
    static let backgroundGray = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.00)
    static let textGray = UIColor(red:0.65, green:0.68, blue:0.71, alpha:1.00)
    static let lightBlue = UIColor(red:0.19, green:0.68, blue:0.94, alpha:1.00)
    static let lightOrange = UIColor(red:1.00, green:0.52, blue:0.00, alpha:1.00)
	
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIDevice {
    static var isSimulator: Bool {
        return ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil
    }
}
