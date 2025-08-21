//
//  Location.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import Foundation
import MapKit

// MARK: - Model for a Location

struct LocationModel: Identifiable, Titled {
    let id: UUID
    let title: String
    var coordinate: CLLocationCoordinate2D

    init(id: UUID = UUID(), title: String, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.title = title
        self.coordinate = coordinate
    }
}
