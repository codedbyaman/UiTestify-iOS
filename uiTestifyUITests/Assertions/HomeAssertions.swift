//
//  HomeAssertions.swift
//  uiTestify
//
//  Created by Aman Kumar on 22/03/26.
//

import XCTest

class HomeAssertions {

    private let elements: HomeElements

    init(elements: HomeElements) {
        self.elements = elements
    }

    func verifyTitleVisible() {
        XCTAssertTrue(
            elements.navigationTitle.waitForExistence(timeout: 5) || elements.title.waitForExistence(timeout: 2),
            "Home title should be visible"
        )
    }

    func verifyHeaderVisible() {
        XCTAssertTrue(elements.greeting.waitForExistence(timeout: 5), "Greeting should be visible")
        XCTAssertTrue(elements.subtitle.waitForExistence(timeout: 5), "Subtitle should be visible")
    }

    func verifyControlsVisible() {
        XCTAssertTrue(elements.darkModeToggle.waitForExistence(timeout: 5), "Dark Mode toggle should be visible")
        XCTAssertTrue(elements.autoRefreshToggle.waitForExistence(timeout: 5), "Auto Refresh toggle should be visible")
        XCTAssertTrue(
            elements.searchBar.waitForExistence(timeout: 2) || elements.searchBarByPlaceholder.waitForExistence(timeout: 5),
            "Search bar should be visible"
        )
    }

    func verifyModuleVisible(_ title: String) {
        XCTAssertTrue(elements.moduleButton(title).waitForExistence(timeout: 5), "\(title) module should be visible")
    }

    func verifyModuleHidden(_ title: String) {
        XCTAssertFalse(elements.moduleButton(title).exists, "\(title) module should be hidden")
    }

    func verifyCategoryVisible(_ title: String) {
        XCTAssertTrue(elements.category(title).waitForExistence(timeout: 5), "\(title) category should be visible")
    }

    func verifySearchText(_ query: String) {
        let searchBar = elements.searchBar.exists ? elements.searchBar : elements.searchBarByPlaceholder
        XCTAssertEqual(searchBar.value as? String, query)
    }

    func verifyDestinationVisible(_ title: String) {
        XCTAssertTrue(elements.moduleLabel(title).waitForExistence(timeout: 5), "\(title) destination should be visible")
    }
}
