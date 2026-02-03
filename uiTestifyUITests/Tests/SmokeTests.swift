//
//  SmokeTests.swift
//  uiTestify
//
//  Created by Aman Kumar on 03/02/26.
//

import XCTest

class SmokeTests: BaseTest {

    func test_appLaunchSuccessfully(){
                // this test will pass and app will visibly open
                XCTAssertTrue(app.state == .runningForeground)
        sleep(5)
    }
}
