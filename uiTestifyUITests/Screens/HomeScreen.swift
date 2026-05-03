//
//  HomeScreen.swift
//  uiTestify
//
//  Created by Aman Kumar on 22/03/26.
//
import XCTest

class HomeScreen {

    let elements: HomeElements
    let actions: HomeActions
    let assertions: HomeAssertions

    init(app: XCUIApplication) {
        self.elements = HomeElements(app: app)
        self.actions = HomeActions(elements: elements)
        self.assertions = HomeAssertions(elements: elements)
    }
}
