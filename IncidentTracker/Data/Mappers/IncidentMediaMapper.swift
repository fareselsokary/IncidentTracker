//
//  IncidentMediaMapper.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - IncidentMediaMapper

/// A utility responsible for mapping API response models (`IncidentMediaResponse`)
/// into domain/UI models (`IncidentMediaModel`).
enum IncidentMediaMapper {
    /// Maps a single `IncidentMediaResponse` into an `IncidentMediaModel`.
    ///
    /// - Parameter response: The API response object representing incident media.
    /// - Returns: An `IncidentMediaModel` domain object.
    static func map(_ response: IncidentMediaResponse) -> IncidentMediaModel {
        return IncidentMediaModel(
            id: response.id,
            mimeType: response.mimeType,
            url: response.url,
            type: response.type,
            incidentId: response.incidentId
        )
    }

    /// Maps an array of `IncidentMediaResponse` objects into an array of `IncidentMediaModel` objects.
    ///
    /// - Parameter responses: A list of API response media objects.
    /// - Returns: A list of mapped `IncidentMediaModel` domain objects.
    static func mapList(_ responses: [IncidentMediaResponse]) -> [IncidentMediaModel] {
        return responses.map { map($0) }
    }
}
