//
//  MainViewControllerTests.swift
//  Netguru Interview App
//
//  Created by Maciej Matuszewski on 29.07.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import XCTest
import EarlGrey
@testable import Netguru_Interview_App

class MainViewControllerTests: XCTestCase {
    
    var viewController: MainViewController!
    
    override func setUp() {
        super.setUp()
        self.viewController = MainViewController.init(presenter: MainPresenter.init())
        FlowManager.shared.present(controller: self.viewController)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testControllerEnterCardNumber(){
        EarlGrey
            .select(elementWithMatcher: grey_accessibilityID("CARD_NUMBER_FIELD"))
            .perform(grey_typeText("1234123412341234"))
            .assert(with: grey_descendant(grey_text("1234 1234 1234 1234")))
    }
    
    func testControllerEnterCardDate(){
        EarlGrey
            .select(elementWithMatcher: grey_accessibilityID("CARD_DATE_FIELD"))
            .perform(grey_typeText("1111"))
            .assert(with: grey_descendant(grey_text("11/11")))
    }
    
    func testControllerEnterCardCVC(){
        EarlGrey
            .select(elementWithMatcher: grey_accessibilityID("CARD_CVC_FIELD"))
            .perform(grey_typeText("111"))
            .assert(with: grey_descendant(grey_text("111")))
    }
    
    func testControllerEnterAllFields(){
        EarlGrey
            .select(elementWithMatcher: grey_accessibilityID("CARD_NUMBER_FIELD"))
            .perform(grey_typeText("12341234123412341111222"))
        
        EarlGrey
            .select(elementWithMatcher: grey_accessibilityID("CARD_CVC_FIELD"))
            .assert(with: grey_descendant(grey_text("222")))
    }
    
    func testControllerClearPreviosField(){
        
        EarlGrey
            .select(elementWithMatcher: grey_accessibilityID("CARD_NUMBER_FIELD"))
            .perform(grey_typeText("12341234123412341111222"))
        
        for _ in 0..<7{
            EarlGrey
                .select(elementWithMatcher: grey_accessibilityID("CARD_CVC_FIELD"))
                .perform(grey_typeText("\u{8}"))
        }
        
        EarlGrey
            .select(elementWithMatcher: grey_accessibilityID("CARD_DATE_FIELD"))
            .assert(with: grey_descendant(grey_text("1")))
    }
    
    func testControllerSetNewCardNumber(){
        let cardNumber = "1234 1234 1234 1234"
        self.viewController.setNewCardNumber(cardNumber)
        EarlGrey
            .select(elementWithMatcher: grey_accessibilityID("CARD_NUMBER_FIELD"))
            .assert(with: grey_descendant(grey_text(cardNumber)))
    }
    
    func testControllerDisplayError(){
        self.viewController.displayError(errorMessage: "TEST ERROR")
        
        EarlGrey
            .select(elementWithMatcher: grey_text("TEST ERROR"))
            .assert(grey_sufficientlyVisible())
            
        EarlGrey
            .select(elementWithMatcher: grey_text("OK"))
            .perform(grey_tap())
    }
    
    func testControllerStartLoading(){
        self.viewController.startLoading()
        EarlGrey
            .select(elementWithMatcher: grey_accessibilityID("STATUS_INDICATOR"))
            .assert(grey_sufficientlyVisible())
        XCTAssert(self.viewController.statusIndicator.state == .loading, "Not correct indicator state")
    }
    
    func testControllerDisplayStatusValid(){
        self.viewController.displayStatus(valid: true)
        EarlGrey
            .select(elementWithMatcher: grey_accessibilityID("STATUS_INDICATOR"))
            .assert(grey_sufficientlyVisible())
        XCTAssert(self.viewController.statusIndicator.state == .success, "Not correct indicator state")
    }
    
    func testControllerDisplayStatusNotValid(){
        self.viewController.displayStatus(valid: false)
        EarlGrey
            .select(elementWithMatcher: grey_accessibilityID("STATUS_INDICATOR"))
            .assert(grey_sufficientlyVisible())
        XCTAssert(self.viewController.statusIndicator.state == .failure, "Not correct indicator state")
    }
    
}
