//
//  AccessibilityIds.swift
//  uiTestify
//
//  Created by Aman Kumar on 04/02/26.
//

struct AccessibilityIds {
    struct HomeView {
        static let titleLabel = "UiTestify Dashboard"
        static let greetingLabel = "Hi, Test User!"
        static let subtitleLabel = "UI Testing Playground"
        static let darkModeLabel = "Dark Mode"
        static let autoRefreshLabel = "Auto Refresh"

        static let titleText = "home_page_title_text"
        static let greetingText = "home_page_greeting_text"
        static let subtitleText = "home_page_subtitle_text"
        static let darkModeToggle = "home_page_dark_mode_toggle"
        static let autoRefreshToggle = "home_page_auto_refresh_toggle"
        static let searchBar = "home_page_searchBar"
        static let searchPlaceholder = "Search tests..."

        static func category(_ title: String) -> String {
            "dashboard_category_\(title.lowercased())"
        }

        static func moduleButton(_ title: String) -> String {
            "dashboard_\(title.replacingOccurrences(of: " ", with: "_").lowercased())_button"
        }
    }
}
