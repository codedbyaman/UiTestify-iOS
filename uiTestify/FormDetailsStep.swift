//
//  FormDetailsStep.swift
//  uiTestify
//
//  Created by Aman Kumar on 24/05/25.
//

import SwiftUI

struct FormDetailsStep: View {
    @Binding var age: String
    @Binding var gender: String
    let genders: [String]

    var body: some View {
        VStack(spacing: 16) {
            TextField("Age", text: $age)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .accessibilityIdentifier("AgeField")

            Picker("Gender", selection: $gender) {
                ForEach(genders, id: \.self) { g in
                    Text(g)
                }
            }
            .pickerStyle(.segmented)
            .accessibilityIdentifier("GenderPicker")
        }
    }
}
