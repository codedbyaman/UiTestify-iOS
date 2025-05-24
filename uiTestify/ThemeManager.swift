//
//  ThemeManager.swift
//  uiTestify
//
//  Created by Aman Kumar on 24/05/25.
//
import SwiftUI
import Combine

class ThemeManager: ObservableObject {
    @Published var isDarkMode: Bool {
        didSet {
            // Update global UIKit tint color
            UIView.appearance().tintColor = UIColor(Color.primary(forDarkMode: isDarkMode))
        }
    }

    init(isDarkMode: Bool = false) {
        self.isDarkMode = isDarkMode
        UIView.appearance().tintColor = UIColor(Color.primary(forDarkMode: isDarkMode))
    }
}
