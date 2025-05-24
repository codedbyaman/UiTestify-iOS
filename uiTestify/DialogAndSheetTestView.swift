//
//  DialogAndSheetTestView.swift
//  uiTestify
//
//  Created by Aman Kumar on 24/05/25.
//

import SwiftUI

struct DialogAndSheetTestView: View {
    @State private var showAlert = false
    @State private var showConfirmation = false
    @State private var showModal = false
    @State private var showToast = false
    @State private var selectedOption = ""

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 24) {
                    Text("Dialog & Sheet Test")
                        .font(.title).bold()

                    // Alert Button
                    Button("Show Alert") {
                        showAlert = true
                    }
                    .accessibilityIdentifier("ShowAlertButton")
                    .buttonStyle(.borderedProminent)

                    // Confirmation Dialog Button
                    Button("Show Confirmation Dialog") {
                        showConfirmation = true
                    }
                    .accessibilityIdentifier("ShowConfirmationButton")
                    .buttonStyle(.borderedProminent)

                    // Sheet Button
                    Button("Open Modal Sheet") {
                        showModal = true
                    }
                    .accessibilityIdentifier("ShowSheetButton")
                    .buttonStyle(.borderedProminent)

                    // Toast Button
                    Button("Show Toast") {
                        withAnimation {
                            showToast = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                showToast = false
                            }
                        }
                    }
                    .accessibilityIdentifier("ShowToastButton")
                    .buttonStyle(.borderedProminent)

                    if !selectedOption.isEmpty {
                        Text("You selected: \(selectedOption)")
                            .font(.headline)
                            .padding()
                    }

                    Spacer()
                }
                .padding()
            }

            // Custom Toast Overlay
            if showToast {
                VStack {
                    Spacer()
                    Text("This is a toast message!")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding()
                        .transition(.move(edge: .bottom))
                        .accessibilityIdentifier("ToastMessage")
                }
            }
        }
        .navigationTitle("Dialogs & Sheets")
        .alert("Important Alert", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("This is a system alert.")
        }
        .confirmationDialog("Choose an Option", isPresented: $showConfirmation, titleVisibility: .visible) {
            Button("Option A") { selectedOption = "Option A" }
            Button("Option B") { selectedOption = "Option B" }
            Button("Cancel", role: .cancel) {}
        }
        .sheet(isPresented: $showModal) {
            ModalSheetView()
        }
    }
}

struct ModalSheetView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("This is a modal sheet.")
                .font(.title2).bold()
            Image(systemName: "square.and.arrow.up")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.purple)
            Text("Presented using `.sheet`")
            Spacer()
        }
        .padding()
        .accessibilityIdentifier("ModalSheet")
    }
}
