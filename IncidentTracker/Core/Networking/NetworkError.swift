//
//  NetworkError.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//


import Foundation

/// Represents errors that can occur during network requests.
///
/// Conforms to `LocalizedError` so that each case provides a
/// user-friendly description via `errorDescription`.
///
/// Typical usage:
/// ```swift
/// do {
///     let user: User = try await networkService.fetch(from: endpoint)
/// } catch let error as NetworkError {
///     print(error.localizedDescription) // human-readable message
/// }
/// ```
enum NetworkError: Error, LocalizedError {

    /// The URL could not be constructed or is invalid.
    case invalidURL

    /// The server returned an unexpected or non-HTTP response.
    case invalidResponse

    /// The server returned an HTTP error with a status code (e.g., 404, 500).
    case httpError(Int)

    /// The response data could not be decoded into the expected model.
    case decodingError(Error)

    /// The request completed but returned no data.
    case noData

    /// A lower-level networking error occurred (e.g., connection failure).
    case networkError(Error)

    /// A human-readable description for each error case.
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response"
        case let .httpError(code):
            return "HTTP error: \(code)"
        case let .decodingError(error):
            return "Decoding error: \(error.localizedDescription)"
        case .noData:
            return "No data received"
        case let .networkError(error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}
