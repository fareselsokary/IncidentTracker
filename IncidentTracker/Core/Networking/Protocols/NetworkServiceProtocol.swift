//
//  NetworkServiceProtocol.swift
//  podcast
//
//  Created by fares on 15/08/2025.
//

import Foundation

/// A protocol that defines a networking service responsible for
/// making API requests and decoding responses.
///
/// Conforming types (e.g., `NetworkService`) should handle the low-level
/// details of building requests, executing them, handling errors, and
/// decoding JSON responses into Swift models.
protocol NetworkServiceProtocol {
    /// Fetches data from the given endpoint using its configured HTTP method,
    /// then decodes the response into the specified `Decodable` type.
    ///
    /// - Parameter endpoint: The endpoint describing the request (URL, path, method, etc.).
    /// - Returns: A decoded object of type `T`.
    /// - Throws: An error if the request fails, the response is invalid,
    ///           or decoding into type `T` fails.
    ///
    /// # Example
    /// ```swift
    /// struct User: Decodable {
    ///     let id: Int
    ///     let name: String
    /// }
    ///
    /// let endpoint = UserEndpoint.profile(id: "123") // conforms to Endpoint
    /// let user: User = try await networkService.fetch(from: endpoint)
    /// ```
    func fetch<T: Decodable>(from endpoint: EndpointProtocol) async throws -> T

    /// Sends a POST request to the given endpoint, then decodes
    /// the response into the specified `Decodable` type.
    ///
    /// - Parameter endpoint: The endpoint describing the request (URL, path, method, etc.).
    /// - Returns: A decoded object of type `T`.
    /// - Throws: An error if the request fails, the response is invalid,
    ///           or decoding into type `T` fails.
    ///
    /// # Example
    /// ```swift
    /// struct LoginResponse: Decodable {
    ///     let token: String
    /// }
    ///
    /// let endpoint = AuthEndpoint.login(email: "test@mail.com", password: "1234")
    /// let response: LoginResponse = try await networkService.post(to: endpoint)
    /// ```
    func post<T: Decodable>(to endpoint: EndpointProtocol) async throws -> T

    /// Uploads data using multipart/form-data encoding.
    ///
    /// - Parameters:
    ///   - endpoint: The endpoint describing the request.
    /// - Returns: A decoded object of type `T`.
    /// - Throws: `NetworkError` if the request or decoding fails.
    func uploadMultipart<T: Decodable>(
        to endpoint: EndpointProtocol
    ) async throws -> T
}
