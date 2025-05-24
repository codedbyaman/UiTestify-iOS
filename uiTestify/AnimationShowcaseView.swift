//
//  AnimationShowcaseView.swift
//  uiTestify
//
//  Created by Aman Kumar on 24/05/25.
//

import SwiftUI

struct AnimationShowcaseView: View {
    @State private var isVisible = false
    @State private var slideOffset: CGFloat = 0
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Double = 0
    @State private var isPulsing = false

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                Text("Animation Showcase")
                    .font(.title).bold()

                // Fade Animation
                VStack {
                    Text("Fade Animation")
                    Image(systemName: "eye")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .opacity(isVisible ? 1 : 0)
                        .animation(.easeInOut, value: isVisible)
                }

                // Slide Animation
                VStack {
                    Text("Slide Animation")
                    Image(systemName: "arrow.right")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .offset(x: slideOffset)
                        .animation(.spring(), value: slideOffset)
                }

                // Scale Animation
                VStack {
                    Text("Scale Animation")
                    Image(systemName: "plus.magnifyingglass")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .scaleEffect(scale)
                        .animation(.easeInOut(duration: 0.3), value: scale)
                }

                // Rotate Animation
                VStack {
                    Text("Rotate Animation")
                    Image(systemName: "goforward")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .rotationEffect(.degrees(rotation))
                        .animation(.easeInOut(duration: 0.5), value: rotation)
                }

                // Pulse (repeatable)
                VStack {
                    Text("Pulse Animation")
                    Circle()
                        .fill(Color.purple)
                        .frame(width: isPulsing ? 80 : 60, height: isPulsing ? 80 : 60)
                        .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: isPulsing)
                }

                // Controls
                VStack(spacing: 12) {
                    Button("Toggle Fade") { isVisible.toggle() }
                    Button("Slide Right") { slideOffset += 50 }
                    Button("Slide Left") { slideOffset -= 50 }
                    Button("Zoom In") { scale += 0.1 }
                    Button("Zoom Out") { scale -= 0.1 }
                    Button("Rotate 45°") { rotation += 45 }
                    Button("Reset") {
                        isVisible = false
                        slideOffset = 0
                        scale = 1.0
                        rotation = 0
                    }
                }
                .buttonStyle(.borderedProminent)

                Spacer()
            }
            .padding()
        }
        .onAppear {
            isPulsing = true
        }
        .navigationTitle("Animations")
    }
}
