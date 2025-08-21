//
//  LoginUseCase.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - LoginUseCaseProtocol

protocol LoginUseCaseProtocol {
    func login(email: String) async throws
}

// MARK: - LoginUseCase

class LoginUseCase: LoginUseCaseProtocol {
    private let repository: AuthenticationRepositoryProtocol

    init(repository: AuthenticationRepositoryProtocol) {
        self.repository = repository
    }

    func login(email: String) async throws {
        let _ = try await repository.login(email: email)
    }
}
