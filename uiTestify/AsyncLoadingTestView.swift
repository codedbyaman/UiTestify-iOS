//
//  AsyncLoadingTestView.swift
//  uiTestify
//
//  Created by Aman Kumar on 24/05/25.
//

import SwiftUI

struct AsyncLoadingTestView: View {
    enum LoadingState {
        case idle, loading, success([String]), failure(String)
    }

    @State private var state: LoadingState = .idle

    var body: some View {
        VStack(spacing: 24) {
            Text("Async & Loading Test")
                .font(.title).bold()

            switch state {
            case .idle:
                Button("Load Data") {
                    simulateLoading()
                }
                .accessibilityIdentifier("LoadButton")
                .buttonStyle(.borderedProminent)

            case .loading:
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .accessibilityIdentifier("LoadingIndicator")

            case .success(let items):
                if items.isEmpty {
                    Text("No data available")
                        .foregroundColor(.gray)
                        .accessibilityIdentifier("EmptyMessage")
                } else {
                    List(items, id: \.self) { item in
                        Text(item)
                            .accessibilityIdentifier("Item_\(item)")
                    }
                }

                Button("Reload") {
                    simulateLoading()
                }
                .accessibilityIdentifier("ReloadButton")
                .padding(.top)

            case .failure(let error):
                Text("Error: \(error)")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .accessibilityIdentifier("ErrorMessage")

                Button("Retry") {
                    simulateLoading()
                }
                .accessibilityIdentifier("RetryButton")
                .padding(.top)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Async Loading")
    }

    private func simulateLoading() {
        state = .loading

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // Simulate random outcome
            let outcome = Int.random(in: 0...2)
            switch outcome {
            case 0:
                state = .success(["Alpha", "Beta", "Gamma"])
            case 1:
                state = .success([])
            default:
                state = .failure("Unable to fetch data. Please try again.")
            }
        }
    }
}
