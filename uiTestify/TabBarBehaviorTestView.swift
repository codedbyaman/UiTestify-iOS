//
//  TabBarBehaviorTestView.swift
//  uiTestify
//
//  Created by Aman Kumar on 24/05/25.
//

import SwiftUI

struct TabBarBehaviorTestView: View {
    @State private var selectedTab = 0
    @State private var showBadge = true

    var body: some View {
        VStack {
            // Badge toggle
            Toggle("Show Notification Badge", isOn: $showBadge)
                .padding()
                .accessibilityIdentifier("ToggleBadge")

            //TabView
            TabView(selection: $selectedTab) {
                TabHomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(0)

                TabSearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                    .tag(1)

                Group {
                    TabProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person.circle")
                        }
                        .tag(2)
                }
                .if(showBadge) { view in
                    view.badge(1)
                }
            }
            .accessibilityIdentifier("MainTabView")
        }
        .navigationTitle("Tab Bar Test")
    }
}

// MARK: - Tab Screens

struct TabHomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Home Tab")
                    .font(.largeTitle)
                NavigationLink("Go to Detail", destination: Text("Detail in Home"))
            }
            .padding()
        }
    }
}

struct TabSearchView: View {
    var body: some View {
        VStack {
            Text("Search Tab")
                .font(.largeTitle)
            TextField("Search here...", text: .constant(""))
                .textFieldStyle(.roundedBorder)
                .padding()
        }
        .padding()
    }
}

struct TabProfileView: View {
    var body: some View {
        VStack {
            Text("Profile Tab")
                .font(.largeTitle)
            Label("Notifications enabled", systemImage: "bell.badge")
        }
        .padding()
    }
}
