//
//  HomevView.swift
//  uiTestify
//
//  Created by Aman Kumar on 24/05/25.
//
import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @AppStorage("autoRefresh") private var autoRefresh = true
    @State private var searchQuery = ""

    private let modules: [TestModule] = TestModule.all

    var filteredModules: [TestModule] {
        if searchQuery.isEmpty { return modules }
        return modules.filter { $0.title.localizedCaseInsensitiveContains(searchQuery) }
    }

    var body: some View {
        NavigationView {
            ZStack {
                (LinearGradient.uiTestifyGradient(forDarkMode: themeManager.isDarkMode))
                    .ignoresSafeArea()

                VStack(spacing: 16) {
                    // Profile & Toggles
                    VStack(spacing: 16) {
                        HStack(spacing: 16) {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 64, height: 64)
                                .foregroundStyle(.white)

                            VStack(alignment: .leading) {
                                Text("Hi, Test User!")
                                    .accessibilityIdentifier("home_page_greeting_text")
                                    .font(.title2).bold()
                                    .foregroundColor(.white)
                                Text("UI Testing Playground")
                                    .accessibilityIdentifier("home_page_subtitle_text")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(12)

                        VStack(spacing: 12) {
                            Toggle("Dark Mode", isOn: $themeManager.isDarkMode)
                                .toggleStyle(SwitchToggleStyle(tint: Color.primary(forDarkMode: themeManager.isDarkMode)))
                                .foregroundColor(.white)
                                .accessibilityIdentifier("home_page_dark_mode_toggle")

                            Toggle("Auto Refresh", isOn: $autoRefresh)
                                .toggleStyle(SwitchToggleStyle(tint: Color.primary(forDarkMode: themeManager.isDarkMode)))
                                .foregroundColor(.white)
                                .accessibilityIdentifier("home_page_auto_refresh_toggle")
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(12)
                    }

                    // Search Bar
                    TextField("Search tests...", text: $searchQuery)
                        .padding(10)
                        .background(Color.white.opacity(0.15))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .accessibilityIdentifier("home_page_searchBar")

                    // Scrollable test modules
                    GeometryReader { geometry in
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(TestModuleCategory.allCases, id: \.self) { category in
                                    let sectionModules = filteredModules.filter { $0.category == category }

                                    if !sectionModules.isEmpty {
                                        AnimatedCategoryHeader(title: category.rawValue)
                                            .accessibilityIdentifier("dashboard_category_\(category.rawValue.lowercased())")

                                        ForEach(sectionModules) { module in
                                            NavigationLink(destination: module.destination) {
                                                Label(module.title, systemImage: module.icon)
                                                    .padding()
                                                    .frame(maxWidth: .infinity)
                                                    .background(Color.white.opacity(0.15))
                                                    .foregroundColor(.white)
                                                    .cornerRadius(10)
                                                    .accessibilityIdentifier("dashboard_\(module.title.replacingOccurrences(of: " ", with: "_").lowercased())_button")

                                            }
                                        }
                                    }
                                }

                                Spacer(minLength: 20)
                            }
                            .padding(.top)
                            .frame(minHeight: geometry.size.height)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("UiTestify Dashboard")
            .accessibilityIdentifier("home_page_title_text")
        }
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
    }
}
