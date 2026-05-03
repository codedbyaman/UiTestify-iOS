//
//  BaseTest.swift
//  uiTestify
//
//  Created by Aman Kumar on 03/02/26.
//

import XCTest

class BaseTest: XCTestCase {

    var app: XCUIApplication!

    // MARK: - Setup

    override func setUpWithError() throws {
        try super.setUpWithError()

        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["-UITest"]
        app.launch()

        handleSystemAlerts()
    }

    override func tearDownWithError() throws {
        captureScreenshotOnFailure()
        app = nil
        try super.tearDownWithError()
    }

    // MARK: - Common Helpers

    func launchApp() {
        app = XCUIApplication()
        app.launch()
    }

    func relaunchApp() {
        app.terminate()
        app.launch()
    }

    func backgroundApp() {
        XCUIDevice.shared.press(.home)
    }

    func bringAppToForeground() {
        app.activate()
    }

    func wait(for element: XCUIElement, timeout: TimeInterval = 5) {
        XCTAssertTrue(
            element.waitForExistence(timeout: timeout),
            "Element not found: \(element)"
        )
    }

    func tap(_ element: XCUIElement, timeout: TimeInterval = 5) {
        wait(for: element, timeout: timeout)
        element.tap()
    }

    // MARK: - Private Helpers

    private func handleSystemAlerts() {
        addUIInterruptionMonitor(withDescription: "System Dialog") { alert in
            if alert.buttons["Allow"].exists {
                alert.buttons["Allow"].tap()
                return true
            }
            if alert.buttons["OK"].exists {
                alert.buttons["OK"].tap()
                return true
            }
            return false
        }

        app.tap()
    }

    private func captureScreenshotOnFailure() {
        if let testRun = self.testRun, !testRun.hasSucceeded {
            let screenshot = XCUIScreen.main.screenshot()
            let attachment = XCTAttachment(screenshot: screenshot)
            attachment.lifetime = .keepAlways
            add(attachment)
        }
    }
}
