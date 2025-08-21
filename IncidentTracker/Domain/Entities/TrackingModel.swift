//
//  Tracking.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - TrackingModel

/// Represents a worker's tracking data linked to an incident.
///
/// This model is part of the domain/UI layer and is suitable for SwiftUI lists
/// since it conforms to `Identifiable` and `Hashable`.
struct TrackingModel: Identifiable, Hashable {
    /// Unique identifier for the tracking entry.
    let id: String

    /// The longitude coordinate of the tracked worker/device.
    let trackingLongitude: Double?

    /// The latitude coordinate of the tracked worker/device.
    let trackingLatitude: Double?

    /// The timestamp when the tracking record was created.
    ///
    /// 2020-12-30 08:30:00.
    let trackingTime: Date?

    /// The identifier of the worker assigned to this tracking entry.
    let assignedWorkerId: String?

    /// Creates a new `TrackingModel` instance.
    ///
    /// - Parameters:
    ///   - trackingId: Unique identifier for the tracking entry.
    ///   - trackingLongitude: The longitude coordinate.
    ///   - trackingLatitude: The latitude coordinate.
    ///   - trackingTime: Timestamp string when the tracking record was created.
    ///   - assignedWorkerId: Identifier of the assigned worker.
    init(
        id: String,
        trackingLongitude: Double?,
        trackingLatitude: Double?,
        trackingTime: Date?,
        assignedWorkerId: String?
    ) {
        self.id = id
        self.trackingLongitude = trackingLongitude
        self.trackingLatitude = trackingLatitude
        self.trackingTime = trackingTime
        self.assignedWorkerId = assignedWorkerId
    }
}
