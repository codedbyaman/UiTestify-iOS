//
//  HomevView.swift
//  uiTestify
//
//  Created by Aman Kumar on 24/05/25.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("autoRefresh") private var autoRefresh = true
    @State private var searchQuery = ""

    private let modules: [TestModule] = TestModule.all

    var filteredModules: [TestModule] {
        if searchQuery.isEmpty { return modules }
        return modules.filter { $0.title.localizedCaseInsensitiveContains(searchQuery) }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // Sticky Top Profile & Toggles
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 64, height: 64)
                            .foregroundStyle(.blue)

                        VStack(alignment: .leading) {
                            Text("Hi, Test User!")
                                .font(.title2).bold()
                            Text("UI Testing Playground")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)

                    VStack(spacing: 12) {
                        Toggle("Dark Mode", isOn: $isDarkMode)
                            .accessibilityIdentifier("DarkModeToggle")
                        Toggle("Auto Refresh", isOn: $autoRefresh)
                            .accessibilityIdentifier("AutoRefreshToggle")
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                }

                // Search
                TextField("Search tests...", text: $searchQuery)
                    .padding(10)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .accessibilityIdentifier("SearchBar")

                // Scrollable test modules
                GeometryReader { geometry in
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(TestModuleCategory.allCases, id: \.self) { category in
                                let sectionModules = filteredModules.filter { $0.category == category }

                                if !sectionModules.isEmpty {
                                    AnimatedCategoryHeader(title: category.rawValue)

                                    ForEach(sectionModules) { module in
                                        NavigationLink(destination: module.destination) {
                                            Label(module.title, systemImage: module.icon)
                                                .padding()
                                                .frame(maxWidth: .infinity)
                                                .background(module.color)
                                                .foregroundColor(.white)
                                                .cornerRadius(8)
                                        }
                                    }
                                }
                            }

                            Spacer(minLength: 20)
                        }
                        .padding(.top)
                        .frame(minHeight: geometry.size.height) // Full height scroll
                    }
                }
            }
            .padding()
            .navigationTitle("UiTestify Dashboard")
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}
