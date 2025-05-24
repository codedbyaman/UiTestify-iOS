import SwiftUI

struct StepIndicator: View {
    let current: Int
    let total: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<total, id: \.self) { i in
                Circle()
                    .fill(i <= current ? Color.accentColor : Color.gray.opacity(0.3))
                    .frame(width: 10, height: 10)
                    .scaleEffect(i == current ? 1.4 : 1.0)
                    .animation(.spring(), value: current)
            }
        }
    }
}

struct FormWizardTestView: View {
    enum Step {
        case basic, details, confirm
    }

    @State private var step: Step = .basic
    @State private var showSubmitSheet = false

    // Form data
    @State private var name = ""
    @State private var email = ""
    @State private var age = ""
    @State private var gender = "Male"

    private let genders = ["Male", "Female", "Other"]

    var body: some View {
        VStack(spacing: 24) {
            Text("Step-by-Step Form")
                .font(.title).bold()

            StepIndicator(current: stepIndex, total: 3)

            switch step {
            case .basic:
                FormBasicStep(name: $name, email: $email)
            case .details:
                FormDetailsStep(age: $age, gender: $gender, genders: genders)
            case .confirm:
                FormConfirmStep(name: name, email: email, age: age, gender: gender)
            }

            HStack {
                if step != .basic {
                    Button("Back") {
                        withAnimation { goBack() }
                    }
                    .accessibilityIdentifier("BackButton")
                }

                Spacer()

                Button(step == .confirm ? "Submit" : "Next") {
                    withAnimation { goForward() }
                }
                .disabled(!isStepValid)
                .buttonStyle(.borderedProminent)
                .accessibilityIdentifier("NextButton")
            }
        }
        .padding()
        .navigationTitle("Form Wizard")
        .sheet(isPresented: $showSubmitSheet) {
            VStack(spacing: 20) {
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.green)

                Text("Form submitted successfully!")
                    .font(.title2).bold()

                Button("Close") {
                    showSubmitSheet = false
                    resetForm()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }

    private var stepIndex: Int {
        switch step {
        case .basic: return 0
        case .details: return 1
        case .confirm: return 2
        }
    }

    private func goBack() {
        switch step {
        case .details: step = .basic
        case .confirm: step = .details
        default: break
        }
    }

    private func goForward() {
        switch step {
        case .basic: step = .details
        case .details: step = .confirm
        case .confirm:
            showSubmitSheet = true
        }
    }

    private func resetForm() {
        step = .basic
        name = ""
        email = ""
        age = ""
        gender = "Male"
    }

    private var isStepValid: Bool {
        switch step {
        case .basic:
            return !name.isEmpty && isValidEmail(email)
        case .details:
            return !age.isEmpty
        case .confirm:
            return true
        }
    }

    private func isValidEmail(_ input: String) -> Bool {
        input.contains("@") && input.contains(".")
    }
}
