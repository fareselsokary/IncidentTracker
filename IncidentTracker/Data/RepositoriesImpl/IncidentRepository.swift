//
//  IncidentRepository.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

class IncidentRepository: IncidentRepositoryProtocol {
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

    func changeIncidentStatus(id: String, status: Int) async throws -> IncidentResponse {
        let endpoint = IncidentEndpoint.changeIncidentStatus(id: id, status: status)
        return try await networkService.fetch(from: endpoint)
    }

    func getIncidents() async throws -> IncidentListResponse {
        let endpoint = IncidentEndpoint.getIncidents
        return try await networkService.fetch(from: endpoint)
    }

    func getIncidentsTypes() async throws -> [IncidentTypeResponse] {
        let endpoint = IncidentEndpoint.getIncidentsTypes
        return try await networkService.fetch(from: endpoint)
    }

    func submitIncident(_ request: SubmitIncidentRequest) async throws -> IncidentListResponse {
        let endpoint = IncidentEndpoint.submitIncident(request)
        return try await networkService.fetch(from: endpoint)
    }

    func uploadIncidentImage(id: String, imageData: Data) async throws -> VoidResponse {
        let endpoint = IncidentEndpoint.uploadIncidentImage(id: id, imageData: imageData)
        return try await networkService.uploadMultipart(to: endpoint)
    }
}
