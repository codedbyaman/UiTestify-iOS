//
//  BaseTest.swift
//  uiTestify
//
//  Created by Aman Kumar on 03/02/26.
//

import XCTest

class BaseTest: XCTestCase {
    var app: XCUIApplication!

    override func setUp(){
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
}
