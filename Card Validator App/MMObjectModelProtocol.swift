//
//  MMObjectModelProtocol.swift
//  Card Validator
//
//  Created by Maciej Matuszewski on 27.07.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import Foundation

/// Protocol for models created from JSON recived from server
protocol MMObjectModelProtocol {
    
    /// Object conform to MMObjectModelProtocol constructor
    ///
    /// - Parameter json: data recived from server
    init?(json:[String:Any])
}
