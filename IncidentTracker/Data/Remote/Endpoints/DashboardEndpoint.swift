//
//  DashboardEndpoint.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - DashboardEndpoint

/// An enumeration that defines API endpoints related to the Dashboard feature.
/// Provides endpoint configuration including URL, HTTP method, and headers.
enum DashboardEndpoint: EndpointProtocol {

    /// Represents the endpoint to fetch the dashboard details.
    case getDashboard

    // MARK: - Base URL

    /// The base URL for all dashboard-related API endpoints.
    /// This value is retrieved from `ServerManager.shared.baseURL`.
    var baseURL: String {
        ServerManager.shared.baseURL
    }

    // MARK: - Path

    /// The specific path for the dashboard endpoint.
    /// Combines with `baseURL` to form the full request URL.
    var path: String {
        ServerEndPoint.Dashboard.details
    }

    // MARK: - HTTP Method

    /// The HTTP method to use for this request.
    /// The dashboard fetch uses a GET request.
    var method: HTTPMethod {
        .get
    }

    // MARK: - Headers

    /// HTTP headers to include in the request.
    /// Uses shared headers from `ServerManager.shared.headers`.
    var headers: [String: String]? {
        ServerManager.shared.headers
    }
}
