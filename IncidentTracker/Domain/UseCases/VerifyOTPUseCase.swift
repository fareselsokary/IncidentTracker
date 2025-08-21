//
//  VerifyOTPUseCase.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - VerifyOTPUseCaseProtocol

protocol VerifyOTPUseCaseProtocol {
    func verifyOTP(email: String, otp: String) async throws -> VerificationModel
}

// MARK: - VerifyOTPUseCase

class VerifyOTPUseCase: VerifyOTPUseCaseProtocol {
    private let repository: AuthenticationRepositoryProtocol

    init(repository: AuthenticationRepositoryProtocol) {
        self.repository = repository
    }

    func verifyOTP(email: String, otp: String) async throws -> VerificationModel {
        let response = try await repository.verifyOTP(email: email, otp: otp)
        return VerificationMapper.map(response)
    }
}
