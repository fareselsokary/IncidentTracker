//
//  View+Maps.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import MapKit

func openMap(latitude: CLLocationDegrees, longitude: CLLocationDegrees, placeName: String? = nil) {
    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    let placemark = MKPlacemark(coordinate: coordinate)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = placeName
    mapItem.openInMaps(launchOptions: [
        MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
    ])
}
