//
//  NetworkService.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - NetworkService

/// A concrete implementation of `NetworkServiceProtocol` that encapsulates
/// HTTP networking with support for JSON, multipart, and error handling.
///
/// ## Features
/// - `GET` requests with query parameters
/// - `POST` (and other methods) with JSON-encoded request bodies
/// - Multipart file upload with form fields
/// - Automatic decoding into `Decodable` models
/// - Centralized error handling via `NetworkError`
///
/// ## Usage
/// ```swift
/// let service = NetworkService.default
/// let model: MyModel = try await service.fetch(from: MyEndpoint())
/// ```
class NetworkService: NetworkServiceProtocol {
    let session: URLSession
    let decoder: JSONDecoder

    /// Creates a new `NetworkService`.
    ///
    /// - Parameters:
    ///   - session: The `URLSession` used for requests (default: `.shared`).
    ///   - decoder: The `JSONDecoder` used for decoding responses (default: plain `JSONDecoder`).
    init(
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
    }

    /// Sends a `GET` request and decodes the response.
    func fetch<T: Decodable>(from endpoint: EndpointProtocol) async throws -> T {
        let request = try buildRequest(from: endpoint)
        return try await performRequest(request)
    }

    /// Sends a non-GET request (e.g., `POST`) with a JSON-encoded body.
    func post<T: Decodable>(to endpoint: EndpointProtocol) async throws -> T {
        let request = try buildRequest(from: endpoint)
        return try await performRequest(request)
    }

    // MARK: - Private Helpers

    /// Builds a `URLRequest` from the given endpoint.
    ///
    /// - Throws: `NetworkError.invalidURL` if URL construction fails.
    private func buildRequest(from endpoint: EndpointProtocol) throws -> URLRequest {
        guard let url = buildURL(
            baseURL: endpoint.baseURL,
            path: endpoint.path,
            parameters: endpoint.method == .get ? endpoint.parameters : nil
        ) else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        // Apply headers
        endpoint.headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        // Encode body for non-GET methods
        if endpoint.method != .get,
           let parameters = endpoint.parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                throw NetworkError.networkError(error)
            }
        }

        return request
    }

    /// Executes a request, validates response, and decodes into `Decodable` type `T`.
    ///
    /// - Behavior:
    ///   - Accepts empty successful responses (`""` or `{}`).
    ///   - Maps plain `"OK"` responses into either `String` or empty object.
    ///   - Throws `NetworkError` for HTTP errors or decoding failures.
    private func performRequest<T: Decodable>(_ request: URLRequest) async throws -> T {
        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }

            guard (200 ... 299).contains(httpResponse.statusCode) else {
                throw NetworkError.httpError(httpResponse.statusCode)
            }

            // Handle empty successful responses
            if data.isEmpty {
                if T.self == String.self {
                    return "OK" as! T
                } else {
                    let emptyData = "{}".data(using: .utf8)!
                    return try decoder.decode(T.self, from: emptyData)
                }
            }

            // Handle plain text "OK"
            if let text = String(data: data, encoding: .utf8),
               text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == "ok" {
                if T.self == String.self {
                    return text as! T
                } else {
                    let emptyData = "{}".data(using: .utf8)!
                    return try decoder.decode(T.self, from: emptyData)
                }
            }

            // Try JSON decoding
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingError(error)
            }

        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.networkError(error)
        }
    }

    /// Constructs a `URL` from components.
    ///
    /// - Supports appending `path` to base URL
    /// - Attaches query parameters if provided
    private func buildURL(baseURL: String, path: String, parameters: [String: Any]?) -> URL? {
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }

        if !path.isEmpty {
            let basePath = urlComponents.path.hasSuffix("/") ? urlComponents.path : urlComponents.path + "/"
            urlComponents.path = basePath + path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        }

        if let parameters = parameters {
            urlComponents.queryItems = parameters.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
        }

        return urlComponents.url
    }
}

// MARK: - NetworkService Multipart Extension

extension NetworkService {
    /// Uploads files and fields using multipart/form-data.
    ///
    /// - Important:
    ///   - Always sets a unique boundary.
    ///   - Custom `Content-Type` headers will NOT override the multipart setting.
    ///
    /// - Returns: Decoded response of type `T`.
    func uploadMultipart<T: Decodable>(
        to endpoint: EndpointProtocol
    ) async throws -> T {
        guard let url = buildURL(
            baseURL: endpoint.baseURL,
            path: endpoint.path,
            parameters: nil
        ) else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        let boundary = "Boundary-\(UUID().uuidString)"

        // Set Content-Type BEFORE custom headers
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        // Apply custom headers (preserving Content-Type)
        endpoint.headers?.forEach { key, value in
            if key.lowercased() != "content-type" {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        // Build multipart body
        let bodyData = createMultipartBody(
            files: endpoint.files,
            fields: endpoint.parameters,
            boundary: boundary
        )

        request.httpBody = bodyData
        request.setValue("\(bodyData.count)", forHTTPHeaderField: "Content-Length")

        return try await performRequest(request)
    }

    // MARK: - Multipart Builder

    /// Constructs a multipart body with form fields and files.
    ///
    /// - Parameters:
    ///   - files: List of files conforming to `MultipartFileProtocol`.
    ///   - fields: Optional dictionary of form fields.
    ///   - boundary: Multipart boundary string.
    private func createMultipartBody(
        files: [MultipartFileProtocol]?,
        fields: [String: Any]?,
        boundary: String
    ) -> Data {
        var body = Data()
        let boundaryData = "--\(boundary)\r\n".data(using: .utf8)!
        let lineBreak = "\r\n".data(using: .utf8)!

        // Append form fields
        if let fields = fields {
            for (key, value) in fields {
                body.append(boundaryData)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                body.append("\(value)".data(using: .utf8)!)
                body.append(lineBreak)
            }
        }

        // Append files
        if let files = files {
            for file in files {
                body.append(boundaryData)
                body.append("Content-Disposition: form-data; name=\"\(file.name)\"; filename=\"\(file.filename)\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: \(file.mimeType)\r\n\r\n".data(using: .utf8)!)
                body.append(file.data)
                body.append(lineBreak)
            }
        }

        // Final boundary
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return body
    }
}

// MARK: - Default Singleton

extension NetworkService {
    /// Shared default instance configured with reasonable timeouts and
    /// ISO8601 decoder (with milliseconds support).
    static let `default`: NetworkService = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60

        let session = URLSession(configuration: configuration)
        return NetworkService(session: session, decoder: .iso8601WithMillisecondsDecoder())
    }()
}
