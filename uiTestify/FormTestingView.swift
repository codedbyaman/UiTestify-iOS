//
//  FormTestingView.swift
//  uiTestify
//
//  Created by Aman Kumar on 24/05/25.
//

import SwiftUI

struct FormTestingView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var agreeToTerms = false
    @State private var selectedRole = "Tester"
    @State private var submitted = false
    @State private var showValidationError = false

    private let roles = ["Tester", "Developer", "Designer", "Manager"]

    var body: some View {
        Form {
            Section(header: Text("User Info")) {
                TextField("Name", text: $name)
                    .accessibilityIdentifier("NameField")
                    .autocapitalization(.words)

                TextField("Email", text: $email)
                    .accessibilityIdentifier("EmailField")
                    .keyboardType(.emailAddress)
            }

            Section(header: Text("Preferences")) {
                Picker("Role", selection: $selectedRole) {
                    ForEach(roles, id: \.self) { role in
                        Text(role)
                    }
                }
                .accessibilityIdentifier("RolePicker")

                Toggle("Agree to Terms", isOn: $agreeToTerms)
                    .accessibilityIdentifier("TermsToggle")
            }

            Section {
                Button("Submit") {
                    if formIsValid {
                        submitted = true
                        showValidationError = false
                        hideKeyboard()
                    } else {
                        submitted = false
                        showValidationError = true
                    }
                }
                .accessibilityIdentifier("SubmitButton")
                .buttonStyle(.borderedProminent)
            }

            if submitted {
                Section {
                    Label("Form submitted successfully!", systemImage: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .accessibilityIdentifier("SuccessMessage")
                }
            }

            if showValidationError {
                Section {
                    Label("Please fill in all fields and agree to terms.", systemImage: "exclamationmark.triangle.fill")
                        .foregroundColor(.red)
                        .accessibilityIdentifier("ErrorMessage")
                }
            }
        }
        .navigationTitle("Form Test")
    }

    private var formIsValid: Bool {
        !name.isEmpty && !email.isEmpty && agreeToTerms
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
