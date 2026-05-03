//
//  SmokeTests.swift
//  uiTestify
//
//  Created by Aman Kumar on 03/02/26.
//

import XCTest

class SmokeTests: BaseTest {

    func test_appLaunchSuccessfully() {
        let home = HomeScreen(app: app)
        home.assertions.verifyTitleVisible()
    }
}
