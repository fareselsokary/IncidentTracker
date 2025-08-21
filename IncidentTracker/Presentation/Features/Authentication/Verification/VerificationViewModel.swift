//
//  VerificationViewModel.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import Foundation

// MARK: - VerificationViewModel

/// ViewModel responsible for handling OTP verification for a given email.
///
/// Manages the input fields, verification request, loading state, and
/// potential messages for errors or success. Uses a `VerifyOTPUseCaseProtocol`
/// to perform the actual verification request.
class VerificationViewModel: ObservableObject {
    /// The email address associated with the OTP verification.
    @Published var email: String = ""

    /// The OTP code entered by the user.
    @Published var code: String = ""

    /// Indicates whether a verification request is currently in progress.
    @Published var isLoading: Bool = false

    /// Holds the current toast message to be displayed, typically for errors or status updates.
    @Published var message: ToastMessage?

    /// The verification result returned by the use case.
    @Published var verification: VerificationModel?

    /// The use case responsible for performing the OTP verification request.
    private let verifyOTPUseCase: VerifyOTPUseCaseProtocol

    /// Initializes the `VerificationViewModel`.
    /// - Parameters:
    ///   - email: The email address for which OTP verification will be performed.
    ///   - verifyOTPUseCase: The use case responsible for verifying the OTP.
    init(
        email: String,
        verifyOTPUseCase: VerifyOTPUseCaseProtocol
    ) {
        self.email = email
        self.verifyOTPUseCase = verifyOTPUseCase
    }
}

// MARK: - Verification Action

extension VerificationViewModel {
    /// Performs OTP verification using the provided email and code.
    ///
    /// Updates `isLoading` during the operation.
    /// On success, sets `verification` with the returned model.
    /// On failure, sets `message` with the error description.
    func verify() {
        Task { @MainActor in
            defer { isLoading = false }
            isLoading = true
            do {
                let response = try await verifyOTPUseCase.verifyOTP(email: email, otp: code)
                verification = response
            } catch {
                message = .error(error.localizedDescription)
            }
        }
    }
}

// MARK: - Computed Properties

extension VerificationViewModel {
    /// Determines whether the verification button should be enabled.
    ///
    /// Returns `true` if the entered code has the required length and no request is in progress.
    var canVerify: Bool {
        code.count == maxCodeLength && !isLoading
    }

    /// The expected length of the OTP code.
    var maxCodeLength: Int {
        4
    }
}
