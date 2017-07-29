//
//  Constans.swift
//  Netguru Interview App
//
//  Created by Maciej Matuszewski on 26.07.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import Foundation
import UIKit

/// Structure that contains constant values used throughout the application
struct Constants {
    
    /// Bincodes Service API key
    public static let apiKey: String = {
        return "5232a9bca11e25c0f8eb4313ff2644be"
    }()
    
    /// Bincodes Service URL
    public static let serverURL: String = {
        return "https://api.bincodes.com/cc/json"
    }()
    
    /// Regular Expresions Patterns for string validation
    struct Paterns {
        
        /// Regular patern that is valid with anything
        static let Anything = "^.*$"
        
        /// Regular patern that is valid with minimum one character
        static let Something = "^.+$"
        
        /// Regular patern that is valid with XXXX XXXX XXXX XXXX,
        /// - X: 0-9
        static let CardNumber = "^[0-9]{4}[ ][0-9]{4}[ ][0-9]{4}[ ][0-9]{4}$"
        
        /// Regular patern that is valid with MM/XX,
        /// - X: 0-9
        /// - MM: 01-12
        static let CardDate = "^([0][1-9]|[1][0-2])[/][0-9]{2}$"
        
        /// Regular patern that is valid with XXX,
        /// - X: 0-9
        static let CardCVC = "^[0-9]{3}$"
    }
    
    /// Values for propery of UI Elements
    struct Values {
        
        /// Value of corner radius
        static let CornerRadius: CGFloat = 6
        
        /// Value of border width
        static let BorderWidth: CGFloat = 0.6
    }
}
