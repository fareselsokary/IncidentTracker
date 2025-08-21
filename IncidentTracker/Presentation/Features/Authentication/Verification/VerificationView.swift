//
//  VerificationView.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import SwiftUI

struct VerificationView: View {
    @StateObject var viewModel: VerificationViewModel
    @EnvironmentObject var sessionManager: SessionManager
    @State private var otpFocused: Bool = false

    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 8) {
                Text("OTP Verification")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .bold()

                Text("Please enter OTP sent to \(viewModel.email)")
                    .foregroundColor(.white)
                    .font(.subheadline)
            }

            VStack(spacing: 40) {
                OTPView(
                    code: $viewModel.code,
                    length: viewModel.maxCodeLength,
                    isFocused: $otpFocused
                )
                .padding(.top, 16)

                Button(action: {
                    viewModel.verify()
                }) {
                    Text("Verify")
                        .font(.body)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(10)
                        .opacity(viewModel.canVerify ? 1 : 0.5)
                }
                .disabled(!viewModel.canVerify)
            }
            .padding()
            .background(.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 15))

            Spacer()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                otpFocused = true
            }
        }
        .padding(.all, 16)
        .padding(.top, 40)
        .toast($viewModel.message)
        .loading(isLoading: viewModel.isLoading)
        .onChange(of: viewModel.verification?.token) { _, newToken in
            if let token = newToken {
                sessionManager.saveToken(token)
            }
        }
    }
}

#Preview {
    VerificationView(viewModel:
        VerificationViewModel(
            email: "test@tester.com",
            verifyOTPUseCase:
            VerifyOTPUseCase(repository: AuthenticationRepository())
        ))
        .preferredColorScheme(.dark)
}
