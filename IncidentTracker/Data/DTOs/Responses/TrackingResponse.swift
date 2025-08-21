//
//  TrackingResponse.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - IncidentResponse

struct TrackingResponse: Codable {
    let trackingId: String
    let trackingLongitude: Double?
    let trackingLatitude: Double?
    let trackingTime: Date?
    let assignedWorkerId: String?

    init(
        trackingId: String,
        trackingLongitude: Double?,
        trackingLatitude: Double?,
        trackingTime: Date?,
        assignedWorkerId: String?

    ) {
        self.trackingId = trackingId
        self.trackingLongitude = trackingLongitude
        self.trackingLatitude = trackingLatitude
        self.trackingTime = trackingTime
        self.assignedWorkerId = assignedWorkerId
    }

    enum CodingKeys: String, CodingKey {
        case trackingLongitude = "TrackingLongitude"
        case trackingLatitude = "TrackingLatitude"
        case trackingTime = "TrackingTime"
        case assignedWorkerId = "AssigedWorkerId"
        case trackingId = "TrackingId"
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        trackingId = try container.decode(String.self, forKey: .trackingId)
        trackingLongitude = try container.decodeIfPresent(Double.self, forKey: .trackingLongitude)
        trackingLatitude = try container.decodeIfPresent(Double.self, forKey: .trackingLatitude)
        trackingTime = try container.decode(Date.self, forKey: .trackingTime)
        assignedWorkerId = try container.decodeIfPresent(String.self, forKey: .assignedWorkerId)
    }
}
