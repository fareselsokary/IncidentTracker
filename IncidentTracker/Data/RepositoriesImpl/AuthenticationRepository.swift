//
//  AuthenticationRepository.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

class AuthenticationRepository: AuthenticationRepositoryProtocol {
    // MARK: - Dependencies

    private let networkService: NetworkServiceProtocol

    // MARK: - Init

    /// Initializes a new `PodcastRepository`.
    ///
    /// - Parameter networkService: A service responsible for performing network requests.
    ///   Defaults to `NetworkService.default`.
    init(networkService: NetworkServiceProtocol = NetworkService.default) {
        self.networkService = networkService
    }

    func login(email: String) async throws -> VoidResponse {
        let endpoint = AuthenticationEndpoint.login(email: email)
        return try await networkService.fetch(from: endpoint)
    }

    func verifyOTP(email: String, otp: String) async throws -> VerificationResponse {
        let endpoint = AuthenticationEndpoint.verifyOTP(email: email, otp: otp)
        return try await networkService.fetch(from: endpoint)
    }
}
