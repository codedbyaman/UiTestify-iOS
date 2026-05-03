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
        XCTAssertTrue(elements.title.waitForExistence(timeout: 5))
    }
}
