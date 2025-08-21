//
//  IncidentDetailsUseCase.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import Foundation

// MARK: - IncidentDetailsUseCaseProtocol

protocol IncidentDetailsUseCaseProtocol {
    func changeIncidentStatus(id: String, status: Int) async throws -> Incident
}

// MARK: - IncidentDetailsUseCase

class IncidentDetailsUseCase: IncidentDetailsUseCaseProtocol {
    private let incidentRepository: IncidentRepositoryProtocol

    init(incidentRepository: IncidentRepositoryProtocol) {
        self.incidentRepository = incidentRepository
    }

    func changeIncidentStatus(id: String, status: Int) async throws -> Incident {
        let response = try await incidentRepository.changeIncidentStatus(id: id, status: status)
        return IncidentMapper.map(response)
    }
}
