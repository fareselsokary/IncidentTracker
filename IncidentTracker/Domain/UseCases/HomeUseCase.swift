//
//  HomeUseCase.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import Foundation

// MARK: - HomeUseCaseProtocol

protocol HomeUseCaseProtocol {
    func getDashboard() async throws -> [DashboardIncidentModel]

    func getIncidents() async throws -> [Incident]
}

// MARK: - HomeUseCase

class HomeUseCase: HomeUseCaseProtocol {
    private let dashboardRepository: DashboardRepositoryProtocol
    private let incidentRepository: IncidentRepositoryProtocol

    init(
        dashboardRepository: DashboardRepositoryProtocol,
        incidentRepository: IncidentRepositoryProtocol
    ) {
        self.dashboardRepository = dashboardRepository
        self.incidentRepository = incidentRepository
    }

    func getDashboard() async throws -> [DashboardIncidentModel] {
        let response = try await dashboardRepository.getDashboard()
        return DashboardMapper.map(response).incidents
    }

    func getIncidents() async throws -> [Incident] {
        let response = try await incidentRepository.getIncidents()
        return IncidentMapper.mapList(response.incidents ?? [])
    }
}
