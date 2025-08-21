//
//  TrackingMapper.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - TrackingMapper

/// A utility responsible for mapping API response models (`TrackingResponse`)
/// into domain/UI models (`TrackingModel`).
enum TrackingMapper {
    /// Maps a single `TrackingResponse` into a `TrackingModel`.
    ///
    /// - Parameter response: The API response object representing a tracking entry.
    /// - Returns: A `TrackingModel` domain object.
    static func map(_ response: TrackingResponse) -> TrackingModel {
        return TrackingModel(
            id: response.trackingId,
            trackingLongitude: response.trackingLongitude,
            trackingLatitude: response.trackingLatitude,
            trackingTime: response.trackingTime,
            assignedWorkerId: response.assignedWorkerId
        )
    }

    /// Maps an array of `TrackingResponse` objects into an array of `TrackingModel` objects.
    ///
    /// - Parameter responses: A list of API response tracking entries.
    /// - Returns: A list of mapped `TrackingModel` domain objects.
    static func mapList(_ responses: [TrackingResponse]) -> [TrackingModel] {
        return responses.map { map($0) }
    }
}
