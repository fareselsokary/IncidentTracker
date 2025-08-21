//
//  IncidentCardViewModel.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import Foundation

// MARK: - IncidentCardViewModel

/// ViewModel for displaying an individual incident in a card view.
///
/// Features:
/// - Holds a single `Incident` object.
/// - Provides computed properties for UI-friendly data display, such as formatted dates, status text, and the first media URL.
class IncidentCardViewModel: ObservableObject {
    /// The incident being displayed.
    @Published var incident: Incident

    /// Initializes the view model with an incident.
    /// - Parameter incident: The incident to display.
    init(incident: Incident) {
        self.incident = incident
    }
}

// MARK: - Computed Properties for Display

extension IncidentCardViewModel {
    /// Returns the URL of the first media item of the incident, if available.
    var imageURL: URL? {
        URL(string: incident.media.first?.url ?? "")
    }

    /// Returns the creation date of the incident formatted as a simple date-time string.
    /// Returns an empty string if `createdAt` is `nil`.
    var createdAt: String {
        incident.createdAt?.toString(formatter: .simpleDateTime) ?? ""
    }

    /// Returns the last updated date of the incident formatted as a simple date-time string.
    /// Returns an empty string if `updatedAt` is `nil`.
    var updatedAt: String {
        incident.updatedAt?.toString(formatter: .simpleDateTime) ?? ""
    }

    /// Returns the name of the incident's status.
    /// Returns an empty string if `status` is `nil`.
    var status: String {
        incident.status?.name ?? ""
    }
}
