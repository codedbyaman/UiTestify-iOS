//
//  FormConfirmStep.swift
//  uiTestify
//
//  Created by Aman Kumar on 24/05/25.
//
import SwiftUI

struct FormConfirmStep: View {
    let name: String
    let email: String
    let age: String
    let gender: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Name: \(name)", systemImage: "person.fill")
            Label("Email: \(email)", systemImage: "envelope.fill")
            Label("Age: \(age)", systemImage: "calendar")
            Label("Gender: \(gender)", systemImage: "person.2.fill")
        }
        .accessibilityIdentifier("ConfirmationSummary")
    }
}
