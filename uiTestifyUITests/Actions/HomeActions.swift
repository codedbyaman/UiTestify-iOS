//
//  HomeActions.swift
//  uiTestify
//
//  Created by Aman Kumar on 22/03/26.
//

import XCTest

class HomeActions {

    private let elements: HomeElements

    init(elements: HomeElements) {
        self.elements = elements
    }

    @discardableResult
    func search(for query: String) -> HomeActions {
        let searchBar = visibleSearchBar()
        searchBar.tap()
        searchBar.typeText(query)
        return self
    }

    @discardableResult
    func clearSearch() -> HomeActions {
        let searchBar = visibleSearchBar()
        searchBar.tap()

        if let value = searchBar.value as? String, !value.isEmpty {
            let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: value.count)
            searchBar.typeText(deleteString)
        }

        return self
    }

    @discardableResult
    func openModule(_ title: String) -> HomeActions {
        let moduleButton = elements.moduleButton(title)
        XCTAssertTrue(moduleButton.waitForExistence(timeout: 5), "\(title) module should be visible")
        moduleButton.tap()
        return self
    }

    @discardableResult
    func scrollDown(times: Int = 1) -> HomeActions {
        for _ in 0..<times {
            elements.page.swipeUp()
        }
        return self
    }

    @discardableResult
    func toggleDarkMode() -> HomeActions {
        let toggle = elements.darkModeToggle
        XCTAssertTrue(toggle.waitForExistence(timeout: 5), "Dark Mode toggle should be visible")
        toggle.tap()
        return self
    }

    @discardableResult
    func toggleAutoRefresh() -> HomeActions {
        let toggle = elements.autoRefreshToggle
        XCTAssertTrue(toggle.waitForExistence(timeout: 5), "Auto Refresh toggle should be visible")
        toggle.tap()
        return self
    }

    private func visibleSearchBar() -> XCUIElement {
        if elements.searchBar.waitForExistence(timeout: 2) {
            return elements.searchBar
        }

        XCTAssertTrue(elements.searchBarByPlaceholder.waitForExistence(timeout: 5), "Search bar should be visible")
        return elements.searchBarByPlaceholder
    }
}
