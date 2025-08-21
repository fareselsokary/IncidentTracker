//
//  WorkerTrackingRepository.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

class WorkerTrackingRepository: WorkerTrackingRepositoryProtocol {
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

    func addWorkerTracking(_ request: AddWorkerTrackingRequest) async throws -> TrackingResponse {
        let endpoint = WorkerTrackingEndpoint.addWorkerTracking(request)
        return try await networkService.fetch(from: endpoint)
    }

    func getWorkerTracking() async throws -> [TrackingResponse] {
        let endpoint = WorkerTrackingEndpoint.getWorkerTracking
        return try await networkService.fetch(from: endpoint)
    }
}
