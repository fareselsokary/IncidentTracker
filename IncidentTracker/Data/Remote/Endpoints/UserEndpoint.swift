//
//  UserEndpoint.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - UserEndpoint

/// An enumeration that defines API endpoints related to fetching user lists.
/// Provides endpoint configuration including URL, HTTP method, and headers.
enum UserEndpoint: EndpointProtocol {
    /// Represents the endpoint to fetch the list of users.
    case getList

    // MARK: - Base URL

    /// The base URL for all user-related endpoints.
    /// Retrieved from `ServerManager.shared.baseURL`.
    var baseURL: String {
        ServerManager.shared.baseURL
    }

    // MARK: - Path

    /// The endpoint-specific path to append to `baseURL`.
    var path: String {
        ServerEndPoint.User.list
    }

    // MARK: - HTTP Method

    /// The HTTP method to use for the request.
    /// The user list fetch uses a GET request.
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
