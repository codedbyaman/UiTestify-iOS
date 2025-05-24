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
        TestModule("Gesture Playground", icon: "hand.tap", color: .blue, destination: AnyView(GesturePlaygroundView()), category: .ui),
        TestModule("Animation Showcase", icon: "sparkles", color: .purple, destination: AnyView(AnimationShowcaseView()), category: .ui),
        TestModule("Form Testing", icon: "rectangle.and.pencil.and.ellipsis", color: .indigo, destination: AnyView(FormTestingView()), category: .ui),
        TestModule("List Interaction", icon: "list.bullet.rectangle", color: .teal, destination: AnyView(ListInteractionView()), category: .ui),
        TestModule("Dialogs & Sheets", icon: "square.and.pencil", color: .orange, destination: AnyView(DialogAndSheetTestView()), category: .ui),
        TestModule("Keyboard & Focus", icon: "keyboard", color: .pink, destination: AnyView(KeyboardFocusTestView()), category: .ui),
        TestModule("Gesture Conflicts", icon: "rectangle.3.offgrid", color: .cyan, destination: AnyView(GestureConflictTestView()), category: .ui),

        TestModule("Network State", icon: "network", color: .green, destination: AnyView(NetworkStateView()), category: .async),
        TestModule("Async & Loading", icon: "clock.arrow.circlepath", color: .mint, destination: AnyView(AsyncLoadingTestView()), category: .async),
        TestModule("Load Test (1000+)", icon: "speedometer", color: .red, destination: AnyView(PerformanceLoadTestView()), category: .async),

        TestModule("Navigation Flow", icon: "arrow.triangle.branch", color: .brown, destination: AnyView(NavigationFlowTestView()), category: .navigation),

        TestModule("Accessibility Test", icon: "figure.wave", color: .gray, destination: AnyView(AccessibilityTestingView()), category: .accessibility),

        TestModule("Tab Bar Behavior", icon: "square.grid.3x1.below.line.grid.1x2", color: .yellow, destination: AnyView(TabBarBehaviorTestView()), category: .ui),

        TestModule("Form Wizard", icon: "rectangle.stack.person.crop", color: .blue, destination: AnyView(FormWizardTestView()), category: .ui)
    ]

    init(_ title: String, icon: String, color: Color, destination: AnyView, category: TestModuleCategory) {
        self.title = title
        self.icon = icon
        self.color = color
        self.destination = destination
        self.category = category
    }
}
