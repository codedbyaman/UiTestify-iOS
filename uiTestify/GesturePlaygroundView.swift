//
//  GesturePlaygroundView.swift
//  uiTestify
//
//  Created by Aman Kumar on 24/05/25.
//

import SwiftUI

struct GesturePlaygroundView: View {
    @State private var tapCount = 0
    @State private var longPressed = false
    @State private var doubleTapped = false
    @State private var dragOffset = CGSize.zero
    @State private var scale: CGFloat = 1.0
    @State private var bounceTap = false
    @State private var rippleEffect = false

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                Text("Gesture Playground")
                    .font(.title)
                    .bold()

                // TAP BOX
                Text("Taps: \(tapCount)")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow)
                    .cornerRadius(12)
                    .scaleEffect(bounceTap ? 1.1 : 1.0)
                    .onTapGesture {
                        tapCount += 1
                        bounceTap = true
                        withAnimation(.easeInOut(duration: 0.2)) {
                            bounceTap = false
                        }
                    }
                    .accessibilityIdentifier("TapBox")

                // LONG PRESS BOX
                Text(longPressed ? "Long Pressed!" : "Long Press Me")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(longPressed ? Color.green : Color.orange)
                    .cornerRadius(12)
                    .scaleEffect(longPressed ? 1.05 : 1.0)
                    .animation(.easeInOut(duration: 0.3), value: longPressed)
                    .onLongPressGesture(minimumDuration: 1) {
                        longPressed.toggle()
                    }
                    .accessibilityIdentifier("LongPressBox")

                // DOUBLE TAP BOX
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(doubleTapped ? Color.purple : Color.blue)
                        .frame(height: 60)

                    if rippleEffect {
                        Circle()
                            .strokeBorder(Color.white.opacity(0.7), lineWidth: 3)
                            .scaleEffect(1.5)
                            .opacity(0)
                            .animation(.easeOut(duration: 0.5), value: rippleEffect)
                    }

                    Text(doubleTapped ? "Double Tapped!" : "Double Tap Me")
                        .foregroundColor(.white)
                        .bold()
                }
                .onTapGesture(count: 2) {
                    doubleTapped.toggle()
                    rippleEffect = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        rippleEffect = false
                    }
                }
                .accessibilityIdentifier("DoubleTapBox")

                // DRAG BOX
                Text("Drag Me")
                    .padding()
                    .background(Color.cyan)
                    .cornerRadius(12)
                    .offset(dragOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { dragOffset = $0.translation }
                            .onEnded { _ in
                                withAnimation(.interpolatingSpring(stiffness: 120, damping: 8)) {
                                    dragOffset = .zero
                                }
                            }
                    )
                    .accessibilityIdentifier("DragBox")

                // PINCH TO ZOOM BOX
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .scaleEffect(scale)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { scale = $0 }
                            .onEnded { _ in
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                    scale = 1.0
                                }
                            }
                    )
                    .accessibilityIdentifier("PinchBox")

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Gestures")
    }
}
