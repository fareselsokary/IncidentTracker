//
//  WorkerTrackingEndpoint.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - WorkerTrackingEndpoint

/// An enumeration that defines API endpoints related to worker tracking.
/// Conforms to `EndpointProtocol` to provide endpoint configuration including
/// URL, HTTP method, headers, and parameters.
enum WorkerTrackingEndpoint: EndpointProtocol {
    /// Submit a new worker tracking entry.
    case addWorkerTracking(AddWorkerTrackingRequest)

    /// Fetch the list of all worker tracking entries.
    case getWorkerTracking

    // MARK: - Base URL

    /// The base URL for all worker tracking endpoints.
    /// Retrieved from `ServerManager.shared.baseURL`.
    var baseURL: String {
        ServerManager.shared.baseURL
    }

    // MARK: - Path

    /// The endpoint-specific path to append to `baseURL`.
    var path: String {
        switch self {
        case .addWorkerTracking:
            return ServerEndPoint.WorkerTracking.submitTrack
        case .getWorkerTracking:
            return ServerEndPoint.WorkerTracking.trackList
        }
    }

    // MARK: - HTTP Method

    /// The HTTP method to use for the request.
    var method: HTTPMethod {
        switch self {
        case .addWorkerTracking:
            return .post
        case .getWorkerTracking:
            return .get
        }
    }

    // MARK: - Headers

    /// HTTP headers to include in the request.
    /// Uses shared headers from `ServerManager.shared.headers`.
    var headers: [String: String]? {
        ServerManager.shared.headers
    }

    // MARK: - Parameters

    /// The parameters to include in the request body.
    /// Only used for `addWorkerTracking` and encoded from the request object.
    var parameters: [String: Any]? {
        switch self {
        case let .addWorkerTracking(request):
            do {
                return try JSONEncoder().encodeToDictionary(request)
            } catch {
                return nil
            }
        case .getWorkerTracking:
            return nil
        }
    }
}
