//
//  DashboardRepositoryProtocol.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

/// Protocol defining the contract for a dashboard repository.
///
/// Provides methods to fetch dashboard-related data from a data source (e.g., API or local cache).
protocol DashboardRepositoryProtocol {
    /// Fetches the dashboard data.
    ///
    /// - Throws: An error if the dashboard retrieval fails (e.g., network error, decoding error).
    /// - Returns: A `DashboardResponse` containing the dashboard data from the API.
    func getDashboard() async throws -> DashboardResponse
}
