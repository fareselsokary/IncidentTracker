//
//  EndpointProtocol.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - EndpointProtocol

/// A protocol that defines the basic requirements for an API endpoint.
///
/// Conforming types represent specific endpoints in a networking layer,
/// making it easier to organize requests in a clean, type-safe way.
///
/// Typical usage:
/// ```swift
/// enum UserEndpoint: EndpointProtocol {
///     case profile(id: String)
///
///     var baseURL: String { "https://api.example.com" }
///
///     var path: String {
///         switch self {
///         case .profile(let id): return "/users/\(id)"
///         }
///     }
///
///     var method: HTTPMethod { .get }
///     var parameters: [String: Any]? { nil }
/// }
///

protocol EndpointProtocol {
    /// The root URL of the API (e.g., `"https://api.example.com"`).
    var baseURL: String { get }

    /// The specific path for this endpoint (e.g., `"/users/123"`).
    var path: String { get }

    /// The HTTP method used for the request (`GET`, `POST`, etc.).
    var method: HTTPMethod { get }

    /// Optional headers for the request.
    var headers: [String: String]? { get }

    /// Optional query/body parameters to include with the request.
    var parameters: [String: Any]? { get }

    /// Optional query/body parameters to include with the request.
    var files: [MultipartFileProtocol]? { get }
}

// MARK: - Default Implementations

extension EndpointProtocol {
    var headers: [String: String]? { nil }

    var parameters: [String: Any]? { nil }

    var files: [MultipartFileProtocol]? { nil }
}
