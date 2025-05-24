//
//  Gesture Conflict Test View.swift
//  uiTestify
//
//  Created by Aman Kumar on 24/05/25.
//

import SwiftUI

struct GestureConflictTestView: View {
    @State private var zoom: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @State private var showHUD = false

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                Text("Gesture Conflict Test")
                    .font(.title).bold()
                    .padding(.top)

                Text("Scroll vertically, drag to pan the image, pinch to zoom, or double-tap to reset.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                ZStack {
                    GeometryReader { geometry in
                        Image(systemName: "photo") // Replace with your image asset
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width)
                            .scaleEffect(zoom)
                            .offset(offset)
                            .gesture(combinedGesture)
                            .onTapGesture(count: 2) {
                                withAnimation {
                                    zoom = 1.0
                                    offset = .zero
                                    lastOffset = .zero
                                    showHUD = true
                                    hideHUD(after: 1.5)
                                }
                            }
                            .accessibilityIdentifier("ZoomableImage")
                    }
                    .frame(height: 300)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)

                    // HUD Overlay
                    if showHUD {
                        Text("Zoom: \(String(format: "%.1f×", zoom))")
                            .font(.caption).bold()
                            .padding(8)
                            .background(Color.black.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .transition(.opacity)
                            .accessibilityIdentifier("ZoomHUD")
                    }
                }

                // Scroll filler content
                ForEach(1..<20) { index in
                    Text("Scrollable content item \(index)")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                        .accessibilityIdentifier("ContentItem_\(index)")
                }

                Spacer(minLength: 40)
            }
            .padding()
        }
        .navigationTitle("Gesture Conflicts")
    }

    var combinedGesture: some Gesture {
        SimultaneousGesture(
            DragGesture()
                .onChanged { value in
                    offset = CGSize(
                        width: lastOffset.width + value.translation.width,
                        height: lastOffset.height + value.translation.height
                    )
                }
                .onEnded { _ in
                    lastOffset = offset
                },
            MagnificationGesture()
                .onChanged { value in
                    zoom = value
                    showHUD = true
                    hideHUD(after: 1.5)
                }
                .onEnded { value in
                    withAnimation {
                        zoom = max(1.0, min(4.0, value))
                    }
                }
        )
    }

    private func hideHUD(after delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            withAnimation {
                showHUD = false
            }
        }
    }
}

