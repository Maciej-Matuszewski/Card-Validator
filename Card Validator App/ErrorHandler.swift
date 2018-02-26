//
//  ErrorHandler.swift
//  Card Validator
//
//  Created by Maciej Matuszewski on 26.07.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import Foundation

class ErrorHandler {
    /// Recognize error base on error code and return message for user
    ///
    /// - Parameter code: (Int) error code
    /// - Returns: (String) Message for user
    static func handleError(code: Int) -> String {
        print("Handle error with code: \(code) 😡")
        switch code {
        case 1001:
            return "API Key Not Specified".localized
        case 1002:
            return "Invalid API Key".localized
        case 1003:
            return "Suspended API Key".localized
        case 1004:
            return "API Usage Limit Exceeded".localized
        case 1005:
            return "Zero Premium API Credit".localized
        case 1006:
            return "Insufficient API Credit".localized
        case 1010:
            return "BIN Not Specified".localized
        case 1011:
            return "Invalid BIN".localized
        case 1012:
            return "BIN Not Found".localized
        case 1013:
            return "Credit Card or Debit Card Number Not Specified".localized
        case 1014:
            return "Invalid Credit Card or Debit Card Number".localized
        case 1015:
            return "Invalid Credit Card or Debit Card Number Length".localized
        case 1016:
            return "Invalid Checksum".localized
        case 1017:
            return "Unsupported BIN".localized
        case 1018:
            return "Unsupported Input Data".localized
        case 1019:
            return "Country or Card or Bank Input Error".localized
        case 1020:
            return "BINS Input Error".localized
        case 1021:
            return "Zero BIN Found".localized
        default:
            return "Something went wrong! Please try again.".localized
        }
    }
}

