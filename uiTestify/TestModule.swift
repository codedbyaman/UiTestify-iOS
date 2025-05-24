//
//  TestModule.swift
//  uiTestify
//
//  Created by Aman Kumar on 24/05/25.
//

import SwiftUI

enum TestModuleCategory: String, CaseIterable {
    case ui = "UI Tests"
    case async = "Async Tests"
    case navigation = "Navigation Tests"
    case accessibility = "Accessibility Tests"
}

struct TestModule: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let color: Color
    let destination: AnyView
    let category: TestModuleCategory

    static let all: [TestModule] = [
        .init("Gesture Playground", icon: "hand.tap", color: .blue, destination: GesturePlaygroundView(), category: .ui),
        .init("Animation Showcase", icon: "sparkles", color: .purple, destination: AnimationShowcaseView(), category: .ui),
        .init("Form Testing", icon: "rectangle.and.pencil.and.ellipsis", color: .indigo, destination: FormTestingView(), category: .ui),
        .init("List Interaction", icon: "list.bullet.rectangle", color: .teal, destination: ListInteractionView(), category: .ui),
        .init("Dialogs & Sheets", icon: "square.and.pencil", color: .orange, destination: DialogAndSheetTestView(), category: .ui),
        .init("Keyboard & Focus", icon: "keyboard", color: .pink, destination: KeyboardFocusTestView(), category: .ui),
        .init("Gesture Conflicts", icon: "rectangle.3.offgrid", color: .cyan, destination: GestureConflictTestView(), category: .ui),

        .init("Network State", icon: "network", color: .green, destination: NetworkStateView(), category: .async),
        .init("Async & Loading", icon: "clock.arrow.circlepath", color: .mint, destination: AsyncLoadingTestView(), category: .async),
        .init("Load Test (1000+)", icon: "speedometer", color: .red, destination: PerformanceLoadTestView(), category: .async),

        .init("Navigation Flow", icon: "arrow.triangle.branch", color: .brown, destination: NavigationFlowTestView(), category: .navigation),

        .init("Accessibility Test", icon: "figure.wave", color: .gray, destination: AccessibilityTestingView(), category: .accessibility),
        
        .init("Tab Bar Behavior", icon: "square.grid.3x1.below.line.grid.1x2", color: .yellow, destination: TabBarBehaviorTestView(), category: .ui),
        
        .init("Form Wizard", icon: "rectangle.stack.person.crop", color: .blue, destination: FormWizardTestView(), category: .ui)

        
    ]

    init<Destination: View>(_ title: String, icon: String, color: Color, destination: Destination, category: TestModuleCategory) {
        self.title = title
        self.icon = icon
        self.color = color
        self.destination = AnyView(destination)
        self.category = category
    }
}
