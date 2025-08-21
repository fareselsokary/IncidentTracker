//
//  IncidentRepositoryProtocol.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

/// Protocol defining the contract for an incident repository.
///
/// Provides methods to manage incidents, including fetching, submitting, updating status, and uploading images.
protocol IncidentRepositoryProtocol {
    /// Changes the status of a specific incident.
    ///
    /// - Parameters:
    ///   - id: The identifier of the incident whose status will be updated.
    ///   - status: The new status to set for the incident.
    /// - Throws: An error if the status change fails (e.g., network error, invalid ID).
    /// - Returns: An `IncidentResponse` containing the updated incident details.
    func changeIncidentStatus(id: String, status: Int) async throws -> IncidentResponse

    /// Fetches the list of incidents.
    ///
    /// - Throws: An error if the request fails (e.g., network error, decoding error).
    /// - Returns: An `IncidentListResponse` containing all incidents.
    func getIncidents() async throws -> IncidentListResponse

    /// Fetches the available types of incidents.
    ///
    /// - Throws: An error if the request fails (e.g., network error, decoding error).
    /// - Returns: An array of `IncidentTypeResponse` representing all possible incident types.
    func getIncidentsTypes() async throws -> [IncidentTypeResponse]

    /// Submits a new incident.
    ///
    /// - Parameter request: A `SubmitIncidentRequest` object containing the incident details to be submitted.
    /// - Throws: An error if the submission fails (e.g., validation error, network error).
    /// - Returns: An `IncidentResponse` containing the newly created incident details.
    func submitIncident(_ request: SubmitIncidentRequest) async throws -> IncidentListResponse

    /// Uploads an image for a specific incident.
    ///
    /// - Parameters:
    ///   - id: The identifier of the incident to attach the image to.
    ///   - imageData: The image data to be uploaded.
    /// - Throws: An error if the upload fails (e.g., network error, invalid image data).
    /// - Returns: A `VoidResponse` indicating the success of the image upload.
    func uploadIncidentImage(id: String, imageData: Data) async throws -> VoidResponse
}
