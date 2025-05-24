//
//  PerformanceLoadTestView.swift
//  uiTestify
//
//  Created by Aman Kumar on 24/05/25.
//

import SwiftUI

struct PerformanceLoadTestView: View {
    @State private var allItems: [String] = (1...1000).map { "Item \($0)" }
    @State private var filterText: String = ""

    var filteredItems: [String] {
        filterText.isEmpty ? allItems : allItems.filter { $0.localizedCaseInsensitiveContains(filterText) }
    }

    var body: some View {
        VStack(spacing: 12) {
            Text("Performance Load Test")
                .font(.title).bold()

            TextField("Search...", text: $filterText)
                .padding(10)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)
                .padding(.horizontal)
                .accessibilityIdentifier("SearchField")

            Text("Total Items: \(filteredItems.count)")
                .font(.subheadline)
                .accessibilityIdentifier("ItemCountLabel")

            Divider()

            ScrollView {
                LazyVStack(spacing: 4, pinnedViews: [.sectionHeaders]) {
                    Section(header: StickyHeaderView()) {
                        ForEach(filteredItems, id: \.self) { item in
                            Text(item)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(Color(UIColor.systemBackground))
                                .overlay(Divider(), alignment: .bottom)
                                .accessibilityIdentifier("ListItem_\(item)")
                        }
                    }
                }
            }
        }
        .navigationTitle("Load Test")
    }
}

struct StickyHeaderView: View {
    var body: some View {
        HStack {
            Text("Scrollable List")
                .font(.headline)
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemGray6))
    }
}
