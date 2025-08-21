//
//  Dashboard.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

// MARK: - DashboardMapper

/// Responsible for mapping API `DashboardResponse` objects into domain `DashboardModel`s.
enum DashboardMapper {
    /// Maps a `DashboardResponse` into a `DashboardModel`.
    ///
    /// - Parameter response: The API response object.
    /// - Returns: A domain `DashboardModel`.
    static func map(_ response: DashboardResponse) -> DashboardModel {
        let incidents = response.incidents?.compactMap(DashboardIncidentMapper.map) ?? []
        return DashboardModel(baseUrl: response.baseUrl, incidents: incidents)
    }
}

// MARK: - DashboardIncidentMapper

/// Responsible for mapping API `DashboardIncidentResponse` objects into domain `DashboardIncidentModel`s.
enum DashboardIncidentMapper {
    /// Maps a `DashboardIncidentResponse` into a `DashboardIncidentModel`.
    ///
    /// This method safely maps the incident status and count:
    /// - If the status from the response cannot be converted to a valid `IncidentsStatus`, mapping returns `nil`.
    /// - The count is safely unwrapped; if missing, it defaults to `0`.
    ///
    /// - Parameter response: The API response object representing a dashboard incident.
    /// - Returns: A `DashboardIncidentModel` with a valid status and count, or `nil` if mapping fails.
    static func map(_ response: DashboardIncidentResponse) -> DashboardIncidentModel? {
        // Convert status string from response into the enum; return nil if invalid
        guard let status = IncidentsStatus(rawValue: response.status) else { return nil }

        // Safely unwrap the count; default to 0 if missing
        let count = response.count?.status ?? 0

        return DashboardIncidentModel(status: status, count: count)
    }
}
