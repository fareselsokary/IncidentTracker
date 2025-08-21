//
//  Incident.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - Incident

/// Represents an incident entity within the application.
///
/// An `Incident` is a domain/UI model that holds information
/// about a reported incident, including its location, status,
/// priority, and any associated media. This model is suitable
/// for use in SwiftUI lists because it conforms to `Identifiable`
/// and `Hashable`.
struct Incident: Identifiable, Hashable {
    /// Unique identifier of the incident.
    let id: String

    /// A textual description of the incident.
    let description: String?

    /// The latitude coordinate where the incident occurred.
    let latitude: Double?

    /// The longitude coordinate where the incident occurred.
    let longitude: Double?

    /// The current status of the incident (raw integer value).
    ///
    /// Typically mapped to a descriptive enum depending on backend definitions.
    let status: IncidentsStatus?

    /// The priority level of the incident (raw integer value).
    ///
    /// Higher values usually indicate more urgent incidents.
    let priority: Int?

    /// The type identifier of the incident (raw integer value).
    ///
    /// Can be mapped to an enum to describe the type (e.g. fire, theft, etc.).
    let typeId: Int?

    /// Identifier of the user who reported the incident.
    let issuerId: String?

    /// Identifier of the user assigned to handle the incident.
    let assigneeId: String?

    /// The creation timestamp of the incident in string format.
    ///
    /// Usually an ISO-8601 formatted date string.
    let createdAt: Date?

    /// The last updated timestamp of the incident in string format.
    ///
    /// Usually an ISO-8601 formatted date string.
    let updatedAt: Date?

    /// A collection of media (e.g., images, videos, files) attached to the incident.
    let media: [IncidentMediaModel]

    /// Creates a new `Incident` instance.
    ///
    /// - Parameters:
    ///   - id: Unique identifier of the incident.
    ///   - description: A textual description of the incident.
    ///   - latitude: The latitude coordinate of the incident.
    ///   - longitude: The longitude coordinate of the incident.
    ///   - status: The current status (as an integer).
    ///   - priority: The priority level (as an integer).
    ///   - typeId: The incident type identifier.
    ///   - issuerId: Identifier of the user who created the incident.
    ///   - assigneeId: Identifier of the assigned handler.
    ///   - createdAt: Date/time string when the incident was created.
    ///   - updatedAt: Date/time string when the incident was last updated.
    ///   - media: Associated media files linked to the incident.
    init(
        id: String,
        description: String?,
        latitude: Double?,
        longitude: Double?,
        status: IncidentsStatus?,
        priority: Int?,
        typeId: Int?,
        issuerId: String?,
        assigneeId: String?,
        createdAt: Date?,
        updatedAt: Date?,
        media: [IncidentMediaModel]
    ) {
        self.id = id
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        self.status = status
        self.priority = priority
        self.typeId = typeId
        self.issuerId = issuerId
        self.assigneeId = assigneeId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.media = media
    }
}

// MARK: - IncidentsStatus

enum IncidentsStatus: Int, CaseIterable {
    case submitted = 0
    case inProgress = 1
    case completed = 2
    case rejected = 3

    init?(rawValue: Int?) {
        switch rawValue {
        case 0:
            self = .submitted
        case 1:
            self = .inProgress
        case 2:
            self = .completed
        case 3:
            self = .rejected
        default:
            return nil
        }
    }

    var name: String {
        switch self {
        case .submitted:
            "Submitted"
        case .inProgress:
            "InProgress"
        case .completed:
            "Completed"
        case .rejected:
            "Rejected"
        }
    }
}

// MARK: Titled, Identifiable

extension IncidentsStatus: Titled, Identifiable {
    var title: String {
        name
    }

    var id: Int {
        rawValue
    }
}
