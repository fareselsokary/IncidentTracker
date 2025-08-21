//
//  OTPView.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import SwiftUI

import SwiftUI

// MARK: - OTPView

/// A reusable One-Time Password (OTP) input view.
///
/// Displays a row of boxes (default: 4) for entering a numeric verification code.
/// Input is handled through a hidden `TextField` so that system keyboard and
/// OTP autofill suggestions work seamlessly.
///
/// Features:
/// - Configurable code length (default = 4)
/// - Restricts input to digits only
/// - Auto-truncates input when exceeding max length
/// - Animates box border when a digit is filled
/// - Pops in each digit with scale + fade animation
struct OTPView: View {
    /// The current OTP code entered by the user
    @Binding var code: String

    /// Number of digits expected in the OTP
    var length: Int = 4

    /// External binding for focus control
    @Binding var isFocused: Bool

    /// Internal state synced with the TextField
    @FocusState private var textFieldFocused: Bool

    // MARK: - Inits

    init(code: Binding<String>, length: Int = 4, isFocused: Binding<Bool> = .constant(false)) {
        _code = code
        self.length = length
        _isFocused = isFocused
    }

    var body: some View {
        ZStack {
            // MARK: Hidden TextField

            // The actual input happens here.
            // It's invisible but ensures keyboard and iOS OTP autofill work.
            TextField("", text: $code)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode) // enables system OTP autofill
                .foregroundColor(.clear) // hide typed text
                .accentColor(.clear) // hide caret
                .disableAutocorrection(true)
                .focused($textFieldFocused)
                .onChange(of: code) { _, newValue in
                    // Restrict input: only digits, max length
                    code = String(newValue.prefix(length).filter { $0.isNumber })
                }

            // MARK: Visible OTP Boxes

            HStack(spacing: 12) {
                ForEach(0 ..< length, id: \.self) { index in
                    ZStack {
                        // Box border
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(borderColor(at: index), lineWidth: 1)
                            .frame(width: 55, height: 60)
                            .animation(.easeInOut(duration: 0.2), value: code)

                        // Display digit if available
                        if let char = charAt(index) {
                            Text(char)
                                .font(.title2)
                                .fontWeight(.bold)
                                .scaleEffect(1.2) // "pop" effect
                                .transition(.scale.combined(with: .opacity))
                                .id(UUID()) // forces re-render for smooth animation
                        }
                    }
                }
            }
        }
        .onTapGesture {
            isFocused = true
        }
        .onChange(of: isFocused) { _, newValue in
            textFieldFocused = newValue
        }
        .onChange(of: textFieldFocused) { _, newValue in
            isFocused = newValue
        }
    }

    // MARK: - Helpers

    /// Returns the digit at the given index in the code, or `nil` if empty.
    private func charAt(_ index: Int) -> String? {
        guard index < code.count else { return nil }
        let stringIndex = code.index(code.startIndex, offsetBy: index)
        return String(code[stringIndex])
    }

    /// Determines the border color of a box.
    /// - Filled digit → orange
    /// - Empty digit → gray
    private func borderColor(at index: Int) -> Color {
        if let _ = charAt(index) {
            return .orange
        } else {
            return .gray
        }
    }
}

// MARK: - Preview

#Preview {
    struct contentView: View {
        @State private var code: String = ""

        var body: some View {
            VStack(spacing: 16) {
                OTPView(code: $code)

                Text("Entered: \(code)")
            }
            .padding()
        }
    }

    return contentView()
}
