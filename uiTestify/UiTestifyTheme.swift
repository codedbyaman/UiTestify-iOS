//
//  UiTestifyTheme.swift
//  uiTestify
//
//  Created by Aman Kumar on 24/05/25.
//
import SwiftUI

// MARK: - Core Theme Colors
extension Color {
    static let lightPrimary = Color(red: 0.18, green: 0.91, blue: 0.82)
    static let lightAccent = Color(red: 0.55, green: 0.25, blue: 0.89)

    static let darkPrimary = Color(red: 0.6, green: 0.75, blue: 0.85)
    static let darkAccent = Color(red: 0.3, green: 0.3, blue: 0.4)

    static func primary(forDarkMode dark: Bool) -> Color {
        dark ? darkPrimary : lightPrimary
    }

    static func accent(forDarkMode dark: Bool) -> Color {
        dark ? darkAccent : lightAccent
    }
}

extension LinearGradient {
    static func uiTestifyGradient(forDarkMode dark: Bool) -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [Color.primary(forDarkMode: dark), Color.accent(forDarkMode: dark)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
