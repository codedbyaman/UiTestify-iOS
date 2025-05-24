//
//  NetworkStateView.swift
//  uiTestify
//
//  Created by Aman Kumar on 24/05/25.
//

import SwiftUI

struct NetworkStateView: View {
    @AppStorage("autoRefresh") private var autoRefresh = true
    @State private var isOnline = true
    @State private var retryCount = 0
    @State private var statusMessage = "Connected"
    @State private var animatePulse = false

    // Auto-refresh timer
    @State private var timer: Timer? = nil

    var body: some View {
        VStack(spacing: 24) {
            Text("Network State Simulator")
                .font(.title).bold()

            // Online/Offline Toggle
            Toggle(isOn: $isOnline.animation(.easeInOut)) {
                Label("Online Mode", systemImage: isOnline ? "wifi" : "wifi.slash")
                    .foregroundColor(isOnline ? .green : .red)
            }
            .padding()
            .accessibilityIdentifier("OnlineToggle")
            .onChange(of: isOnline) { value in
                updateStatus()
            }

            // Retry Button with Pulse Animation
            Button(action: {
                retryCount += 1
                animatePulse = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    animatePulse = false
                }
                updateStatus()
            }) {
                Label("Retry Now", systemImage: "arrow.clockwise")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(animatePulse ? Color.orange.opacity(0.7) : Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .scaleEffect(animatePulse ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 0.3), value: animatePulse)
            }
            .accessibilityIdentifier("RetryButton")

            // Status Display with Color Feedback
            VStack(spacing: 8) {
                Text(statusMessage)
                    .foregroundColor(isOnline ? .green : .red)
                    .font(.headline)
                Text("Retries: \(retryCount)")
                Text("Auto-Refresh: \(autoRefresh ? "Enabled" : "Disabled")")
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Network State")
        .onAppear {
            updateStatus()
            startAutoRefreshIfNeeded()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }

    private func updateStatus() {
        if isOnline {
            statusMessage = retryCount > 0 ? "Reconnected after \(retryCount) retry\(retryCount > 1 ? "ies" : "")" : "Connected"
        } else {
            statusMessage = "Offline Mode"
        }
    }

    private func startAutoRefreshIfNeeded() {
        guard autoRefresh else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            retryCount += 1
            updateStatus()
        }
    }
}

