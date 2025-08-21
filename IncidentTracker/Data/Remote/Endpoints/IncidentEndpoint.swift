//
//  IncidentEndpoint.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - IncidentEndpoint

/// An enumeration that defines API endpoints related to incident management.
/// Conforms to `EndpointProtocol` to provide endpoint configuration including
/// URL, HTTP method, headers, parameters, and file uploads.
enum IncidentEndpoint: EndpointProtocol {
    /// Change the status of an incident.
    case changeIncidentStatus(id: String, status: Int)

    /// Fetch the list of incidents.
    case getIncidents

    /// Fetch the list of available incident types.
    case getIncidentsTypes

    /// Submit a new incident with a detailed request object.
    case submitIncident(SubmitIncidentRequest)

    /// Upload an image associated with a specific incident.
    case uploadIncidentImage(id: String, imageData: Data)

    // MARK: - Base URL

    /// The base URL for all incident-related endpoints.
    /// Retrieved from `ServerManager.shared.baseURL`.
    var baseURL: String {
        ServerManager.shared.baseURL
    }

    // MARK: - Path

    /// The endpoint-specific path to append to `baseURL`.
    var path: String {
        switch self {
        case .changeIncidentStatus:
            return ServerEndPoint.Incident.changeStatus
        case .getIncidents:
            return ServerEndPoint.Incident.list
        case .getIncidentsTypes:
            return ServerEndPoint.Incident.types
        case .submitIncident:
            return ServerEndPoint.Incident.submit
        case let .uploadIncidentImage(id, _):
            return String(format: ServerEndPoint.Incident.uploadImage, id)
        }
    }

    // MARK: - HTTP Method

    /// The HTTP method to use for the request.
    var method: HTTPMethod {
        switch self {
        case .changeIncidentStatus:
            return .put
        case .getIncidents,
             .getIncidentsTypes:
            return .get
        case .submitIncident,
             .uploadIncidentImage:
            return .post
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
    /// Returns `nil` for endpoints that do not require a request body.
    var parameters: [String: Any]? {
        switch self {
        case let .changeIncidentStatus(id, status):
            return [
                "incidentId": id,
                "status": status
            ]
        case .getIncidents,
             .getIncidentsTypes,
             .uploadIncidentImage:
            return nil
        case let .submitIncident(request):
            do {
                // Encode the request object as a dictionary
                return try JSONEncoder().encodeToDictionary(request)
            } catch {
                return nil
            }
        }
    }

    // MARK: - File Uploads

    /// Files to upload as multipart/form-data.
    /// Only used for uploading incident images.
    var files: [MultipartFileProtocol]? {
        switch self {
        case let .uploadIncidentImage(_, imageData):
            return [MultipartFile(
                name: "image",
                filename: "\(UUID().uuidString).jpg", // unique filename
                mimeType: "image/jpeg", // JPEG MIME type
                data: imageData
            )]
        default:
            return nil
        }
    }
}
