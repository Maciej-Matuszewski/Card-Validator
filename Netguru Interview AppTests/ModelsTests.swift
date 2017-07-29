//
//  ModelsTests.swift
//  Netguru Interview App
//
//  Created by Maciej Matuszewski on 29.07.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import XCTest
import EarlGrey
@testable import Netguru_Interview_App

class ModelsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCardInfoModelMap(){
        
        let json = [
            "bin": "bin",
            "bank": "bank",
            "card": "card",
            "type": "type",
            "level": "level",
            "country": "country",
            "countrycode": "countrycode",
            "website": "website",
            "phone": "phone",
            "valid": "true"
        ]
        
        let model = CardInfoModel.init(json: json)
        
        XCTAssert(model.bin == "bin")
        XCTAssert(model.bank == "bank")
        XCTAssert(model.card == "card")
        XCTAssert(model.type == "type")
        XCTAssert(model.level == "level")
        XCTAssert(model.country == "country")
        XCTAssert(model.countrycode == "countrycode")
        XCTAssert(model.website == "website")
        XCTAssert(model.phone == "phone")
        XCTAssert(model.valid == true)
    }
    
    func testErrorModelMap(){
        
        let json = [
            "error": "-999",
            "message": "message"
        ]
        
        let model = ErrorModel.init(json: json)
        
        XCTAssert(model?.error == -999)
        XCTAssert(model?.message == "message")
    }
    
    func testErrorModelMapIntoNil(){
        
        let json:[String:Any] = [:]
        
        let model = ErrorModel.init(json: json)
        
        XCTAssert(model == nil)
    }
}
