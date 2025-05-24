//
//  ListInteractionView.swift
//  uiTestify
//
//  Created by Aman Kumar on 24/05/25.
//

import SwiftUI

struct ListItem: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var isSelected: Bool = false
}

struct ListInteractionView: View {
    @State private var items: [ListItem] = (1...10).map { ListItem(title: "Item \($0)") }
    @State private var isEditing = false

    var body: some View {
        VStack {
            HStack {
                Text("List Interaction")
                    .font(.title2).bold()
                Spacer()
                EditButton()
                    .accessibilityIdentifier("EditButton")
            }
            .padding(.horizontal)

            if items.isEmpty {
                Spacer()
                Text("No items available")
                    .foregroundColor(.gray)
                    .font(.headline)
                    .accessibilityIdentifier("EmptyState")
                Spacer()
            } else {
                List {
                    ForEach(items) { item in
                        HStack {
                            Text(item.title)
                            Spacer()
                            if item.isSelected {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.blue)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            toggleSelection(for: item)
                        }
                        .accessibilityIdentifier("ListItem_\(item.title)")
                    }
                    .onDelete(perform: deleteItems)
                    .onMove(perform: moveItems)
                }
                .environment(\.editMode, .constant(isEditing ? .active : .inactive))
            }

            Button(isEditing ? "Done" : "Reorder") {
                isEditing.toggle()
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .accessibilityIdentifier("ReorderButton")
        }
        .navigationTitle("List Interaction")
    }

    private func toggleSelection(for item: ListItem) {
        if let index = items.firstIndex(of: item) {
            items[index].isSelected.toggle()
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

    private func moveItems(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
}
