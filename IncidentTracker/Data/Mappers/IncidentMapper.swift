//
//  IncidentMapper.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - IncidentMapper

/// A utility responsible for mapping API response models (`IncidentResponse`)
/// into domain/UI models (`Incident`).
enum IncidentMapper {
    /// Maps a single `IncidentResponse` into an `Incident` model.
    ///
    /// - Parameter response: The API response object representing an incident.
    /// - Returns: An `Incident` model suitable for use in the app's domain layer.
    static func map(_ response: IncidentResponse) -> Incident {
        return Incident(
            id: response.id,
            description: response.description,
            latitude: response.latitude,
            longitude: response.longitude,
            status: IncidentsStatus(rawValue: response.status),
            priority: response.priority,
            typeId: response.typeId,
            issuerId: response.issuerId,
            assigneeId: response.assigneeId,
            createdAt: response.createdAt,
            updatedAt: response.updatedAt,
            media: IncidentMediaMapper.mapList(response.media ?? [])
        )
    }

    /// Maps an array of `IncidentResponse` objects into an array of `Incident` models.
    ///
    /// - Parameter responses: A list of API response incidents.
    /// - Returns: A list of mapped `Incident` models.
    static func mapList(_ responses: [IncidentResponse]) -> [Incident] {
        return responses.map { map($0) }
    }
}
