//
//  AddWorkerTrackRequest.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

struct AddWorkerTrackingRequest: Encodable {
    let trackingLongitude: Double
    let trackingLatitude: Double
    let trackingTime: Date
    let busNumber: String

    init(
        trackingLongitude: Double,
        trackingLatitude: Double,
        trackingTime: Date,
        busNumber: String
    ) {
        self.trackingLongitude = trackingLongitude
        self.trackingLatitude = trackingLatitude
        self.trackingTime = trackingTime
        self.busNumber = busNumber
    }

    enum CodingKeys: String, CodingKey {
        case trackingLongitude = "TrackingLongitude"
        case trackingLatitude = "TrackingLatitude"
        case trackingTime = "TrackingTime"
        case busNumber = "BusNumber"
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(trackingLongitude, forKey: .trackingLongitude)
        try container.encodeIfPresent(trackingLatitude, forKey: .trackingLatitude)

        let formattedData = trackingTime.toString(formatter: .standardDateTime)
        try container.encodeIfPresent(formattedData, forKey: .trackingTime)

        try container.encodeIfPresent(busNumber, forKey: .busNumber)
    }
}
