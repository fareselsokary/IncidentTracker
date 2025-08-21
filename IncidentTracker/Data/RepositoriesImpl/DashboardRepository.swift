//
//  DashboardRepository.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

class DashboardRepository: DashboardRepositoryProtocol {
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

    func getDashboard() async throws -> DashboardResponse {
        let endpoint = DashboardEndpoint.getDashboard
        return try await networkService.fetch(from: endpoint)
    }
}
