//
//  AuthenticationRepositoryProtocol.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

/// Protocol defining the contract for an authentication repository.
///
/// Provides methods for handling user login and OTP verification.
protocol AuthenticationRepositoryProtocol {
    /// Logs in a user using their email address.
    ///
    /// - Parameter email: The email address of the user attempting to log in.
    /// - Throws: An error if the login operation fails (e.g., network error, invalid email).
    /// - Returns: A `VoidResponse` indicating the success of the login operation.
    func login(email: String) async throws -> VoidResponse

    /// Verifies a one-time password (OTP) for a given authentication session.
    ///
    /// - Parameters:
    ///   - email: The email address associated with the login session.
    ///   - otp: The one-time password sent to the user for verification.
    /// - Throws: An error if the OTP verification fails (e.g., invalid OTP, expired session).
    /// - Returns: A `VerificationResponse` containing the result of the verification process.
    func verifyOTP(email: String, otp: String) async throws -> VerificationResponse
}
