//
//  CLLocationCoordinate2D.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import CoreLocation

// MARK: - CLLocationCoordinate2D + Equatable

extension CLLocationCoordinate2D: @retroactive Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
