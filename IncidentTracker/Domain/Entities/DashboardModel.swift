//
//  DashboardModel.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

// MARK: - DashboardModel

/// Domain model representing dashboard data in the app.
struct DashboardModel {
    /// The base URL for dashboard operations.
    let baseUrl: String?
    /// List of dashboard incidents.
    let incidents: [DashboardIncidentModel]

    init(baseUrl: String?, incidents: [DashboardIncidentModel]) {
        self.baseUrl = baseUrl
        self.incidents = incidents
    }
}

// MARK: - DashboardIncidentModel

/// Domain model representing a single dashboard incident.
struct DashboardIncidentModel {
    /// Status code of the incident.
    let status: IncidentsStatus
    /// Count information for the incident.
    let count: Int

    init(status: IncidentsStatus, count: Int) {
        self.status = status
        self.count = count
    }
}
