//
//  HomeElement.swift
//  uiTestify
//
//  Created by Aman Kumar on 04/02/26.
//

import XCTest

class HomeElements {

    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    var navigationTitle: XCUIElement {
        app.navigationBars[AccessibilityIds.HomeView.titleLabel]
    }

    var title: XCUIElement {
        app.staticTexts[AccessibilityIds.HomeView.titleLabel]
    }

    var greeting: XCUIElement {
        app.staticTexts[AccessibilityIds.HomeView.greetingLabel]
    }

    var subtitle: XCUIElement {
        app.staticTexts[AccessibilityIds.HomeView.subtitleLabel]
    }

    var darkModeToggle: XCUIElement {
        app.switches[AccessibilityIds.HomeView.darkModeLabel]
    }

    var autoRefreshToggle: XCUIElement {
        app.switches[AccessibilityIds.HomeView.autoRefreshLabel]
    }

    var searchBar: XCUIElement {
        app.textFields[AccessibilityIds.HomeView.searchBar]
    }

    var searchBarByPlaceholder: XCUIElement {
        app.textFields[AccessibilityIds.HomeView.searchPlaceholder]
    }

    var page: XCUIElement {
        app.firstMatch
    }

    func category(_ title: String) -> XCUIElement {
        app.staticTexts[title]
    }

    func moduleButton(_ title: String) -> XCUIElement {
        app.buttons[AccessibilityIds.HomeView.moduleButton(title)]
    }

    func moduleLabel(_ title: String) -> XCUIElement {
        app.staticTexts[title]
    }
}
