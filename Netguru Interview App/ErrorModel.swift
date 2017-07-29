//
//  ErrorModel.swift
//  Netguru Interview App
//
//  Created by Maciej Matuszewski on 27.07.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import UIKit

class ErrorModel:NSObject, MMObjectModelProtocol {
    
    /// code of error
    let error: Int
    
    /// message of error
    let message: String
    
    /// __ErrorModel__ constructor
    ///
    /// - Parameter json: data recived from server
    required init?(json:[String:Any]){
        
        guard
            let error = Int.init(json["error"] as? String ?? ""),
            let message = json["message"] as? String
        else{
            return nil
        }
        
        self.error = error
        self.message = message
        
        super.init()
    }
}
