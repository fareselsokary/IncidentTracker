//
//  AddIncidentUseCase.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import Foundation

// MARK: - AddIncidentUseCaseProtocol

protocol AddIncidentUseCaseProtocol {
    func getIncidentsTypes() async throws -> [IncidentTypeModel]
    func submitIncident(_ request: SubmitIncidentRequest) async throws -> Incident?
    func uploadIncidentImage(id: String, imageData: Data) async throws
}

// MARK: - AddIncidentUseCase

class AddIncidentUseCase: AddIncidentUseCaseProtocol {
    private let incidentRepository: IncidentRepositoryProtocol

    init(incidentRepository: IncidentRepositoryProtocol) {
        self.incidentRepository = incidentRepository
    }

    func getIncidentsTypes() async throws -> [IncidentTypeModel] {
        let response = try await incidentRepository.getIncidentsTypes()
        return IncidentTypeMapper.map(response)
    }

    func submitIncident(_ request: SubmitIncidentRequest) async throws -> Incident? {
        let response = try await incidentRepository.submitIncident(request)
        return IncidentMapper.mapList(response.incidents ?? []).first
    }

    func uploadIncidentImage(id: String, imageData: Data) async throws {
        let _ = try await incidentRepository.uploadIncidentImage(id: id, imageData: imageData)
    }
}
