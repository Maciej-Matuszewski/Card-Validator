//
//  CardInfoModel.swift
//  Card Validator
//
//  Created by Maciej Matuszewski on 27.07.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import UIKit

class CardInfoModel:NSObject, MMObjectModelProtocol {
    
    let bin: String?
    let bank: String?
    let card: String?
    let type: String?
    let level: String?
    let country: String?
    let countrycode: String?
    let website: String?
    let phone: String?
    let valid: Bool?
    
    /// __CardInfoModel__ constructor
    ///
    /// - Parameter json: data recived from server
    required init(json:[String:Any]){
        self.bin = json["bin"] as? String
        self.bank = json["bank"] as? String
        self.card = json["card"] as? String
        self.type = json["type"] as? String
        self.level = json["level"] as? String
        self.country = json["country"] as? String
        self.countrycode = json["countrycode"] as? String
        self.website = json["website"] as? String
        self.phone = json["phone"] as? String
        self.valid = json["valid"] as? String == "true" ? true : false
        super.init()
    }
}
