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
        home.assertions.verifyHeaderVisible()
        home.assertions.verifyControlsVisible()
    }

    func test_dashboardShowsExpectedCategoriesAndModules() {
        let home = HomeScreen(app: app)

        home.assertions.verifyCategoryVisible("UI Tests")
        home.assertions.verifyModuleVisible("Gesture Playground")
        home.assertions.verifyModuleVisible("Form Testing")

        home.actions.scrollDown()

        home.assertions.verifyCategoryVisible("Async Tests")
        home.assertions.verifyModuleVisible("Network State")

        home.actions.scrollDown(times: 2)

        home.assertions.verifyCategoryVisible("Navigation Tests")
        home.assertions.verifyCategoryVisible("Accessibility Tests")
        home.assertions.verifyModuleVisible("Navigation Flow")
        home.assertions.verifyModuleVisible("Accessibility Test")
    }

    func test_searchFiltersDashboardModules() {
        let home = HomeScreen(app: app)

        home.actions.search(for: "Form")

        home.assertions.verifySearchText("Form")
        home.assertions.verifyModuleVisible("Form Testing")
        home.assertions.verifyModuleHidden("Gesture Playground")
    }

    func test_openModuleNavigatesToDestination() {
        let home = HomeScreen(app: app)

        home.actions.openModule("Form Testing")

        home.assertions.verifyDestinationVisible("Form Test")
    }
}
