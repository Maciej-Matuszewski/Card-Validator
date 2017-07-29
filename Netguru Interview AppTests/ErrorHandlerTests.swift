//
//  ErrorHandlerTests.swift
//  Netguru Interview App
//
//  Created by Maciej Matuszewski on 29.07.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//


import XCTest
import EarlGrey
@testable import Netguru_Interview_App

class ErrorHandlerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testErrorHandlerMessage(){
        XCTAssert(ErrorHandler.handleError(code: 1001) == "API Key Not Specified".localized)
        XCTAssert(ErrorHandler.handleError(code: 1002) == "Invalid API Key".localized)
        XCTAssert(ErrorHandler.handleError(code: 1003) == "Suspended API Key".localized)
        XCTAssert(ErrorHandler.handleError(code: 1004) == "API Usage Limit Exceeded".localized)
        XCTAssert(ErrorHandler.handleError(code: 1005) == "Zero Premium API Credit".localized)
        XCTAssert(ErrorHandler.handleError(code: 1006) == "Insufficient API Credit".localized)
        XCTAssert(ErrorHandler.handleError(code: 1010) == "BIN Not Specified".localized)
        XCTAssert(ErrorHandler.handleError(code: 1011) == "Invalid BIN".localized)
        XCTAssert(ErrorHandler.handleError(code: 1012) == "BIN Not Found".localized)
        XCTAssert(ErrorHandler.handleError(code: 1013) == "Credit Card or Debit Card Number Not Specified".localized)
        XCTAssert(ErrorHandler.handleError(code: 1014) == "Invalid Credit Card or Debit Card Number".localized)
        XCTAssert(ErrorHandler.handleError(code: 1015) == "Invalid Credit Card or Debit Card Number Length".localized)
        XCTAssert(ErrorHandler.handleError(code: 1016) == "Invalid Checksum".localized)
        XCTAssert(ErrorHandler.handleError(code: 1017) == "Unsupported BIN".localized)
        XCTAssert(ErrorHandler.handleError(code: 1018) == "Unsupported Input Data".localized)
        XCTAssert(ErrorHandler.handleError(code: 1019) == "Country or Card or Bank Input Error".localized)
        XCTAssert(ErrorHandler.handleError(code: 1020) == "BINS Input Error".localized)
        XCTAssert(ErrorHandler.handleError(code: 1021) == "Zero BIN Found".localized)
        XCTAssert(ErrorHandler.handleError(code: -1) == "Something went wrong! Please try again.".localized)
    }
    
    
}
