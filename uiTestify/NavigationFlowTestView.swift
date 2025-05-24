//
//  NavigationFlowTestView.swift
//  uiTestify
//
//  Created by Aman Kumar on 24/05/25.
//

import SwiftUI

struct NavigationFlowTestView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Navigation Flow Test")
                    .font(.title).bold()

                NavigationLink("Start Flow", destination: FlowStepOneView())
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .accessibilityIdentifier("StartFlowButton")
            }
            .padding()
            .navigationTitle("Flow Start")
        }
    }
}

struct FlowStepOneView: View {
    @State private var name: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Step 1: Enter Name")
                .font(.title2)

            TextField("Your Name", text: $name)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .accessibilityIdentifier("NameField")

            NavigationLink("Next", destination: FlowStepTwoView(userName: name))
                .disabled(name.isEmpty)
                .opacity(name.isEmpty ? 0.5 : 1)
                .accessibilityIdentifier("NextButton")
        }
        .padding()
        .navigationTitle("Step 1")
    }
}

struct FlowStepTwoView: View {
    let userName: String
    @State private var isSubmitted = false

    var body: some View {
        VStack(spacing: 20) {
            if isSubmitted {
                Label("Thanks, \(userName)!", systemImage: "checkmark.seal.fill")
                    .font(.title2)
                    .foregroundColor(.green)
                    .accessibilityIdentifier("SuccessMessage")
            } else {
                Text("Step 2: Confirm Name")
                    .font(.title2)

                Text("You entered: \(userName)")
                    .font(.headline)

                Button("Submit") {
                    isSubmitted = true
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .accessibilityIdentifier("SubmitButton")
            }
        }
        .padding()
        .navigationTitle("Step 2")
    }
}
