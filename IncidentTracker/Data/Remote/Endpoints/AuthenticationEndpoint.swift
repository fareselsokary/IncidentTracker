//
//  AuthenticationEndpoint.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - AuthenticationEndpoint

/// An enumeration that defines authentication-related API endpoints.
/// Conforms to `EndpointProtocol` to provide information about the endpoint's
/// URL, HTTP method, headers, and parameters.
enum AuthenticationEndpoint: EndpointProtocol {
    /// Represents the login endpoint, requiring an email address.
    case login(email: String)

    /// Represents the OTP verification endpoint, requiring an ID and OTP data.
    case verifyOTP(email: String, otp: String)

    // MARK: - Base URL

    /// The base URL for all authentication endpoints.
    /// This value is retrieved from `ServerManager.shared.baseURL`.
    var baseURL: String {
        ServerManager.shared.baseURL
    }

    // MARK: - Path

    /// The specific path for the endpoint.
    /// Combines with the `baseURL` to form the full URL.
    var path: String {
        switch self {
        case .login:
            return ServerEndPoint.Auth.login
        case .verifyOTP:
            return ServerEndPoint.Auth.verifyOTP
        }
    }

    // MARK: - HTTP Method

    /// The HTTP method to be used for the request.
    /// Both login and verify OTP endpoints use `POST`.
    var method: HTTPMethod {
        .post
    }

    // MARK: - Headers

    /// The HTTP headers to include in the request.
    /// Shared headers are retrieved from `ServerManager.shared.headers`.
    var headers: [String: String]? {
        ServerManager.shared.headers
    }

    // MARK: - Parameters

    /// The parameters to include in the request body.
    /// - For `login`, includes the user's email.
    /// - For `verifyOTP`, includes the email and OTP data.
    var parameters: [String: Any]? {
        switch self {
        case let .login(email):
            return [
                "email": email
            ]
        case let .verifyOTP(email, otp):
            return [
                "email": email,
                "otp": otp
            ]
        }
    }
}
