//
//  IncidentMediaModel.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - IncidentMediaModel

/// Represents media associated with an incident.
///
/// This model is part of the domain layer and is suitable for use in SwiftUI views
/// since it conforms to `Identifiable` and `Hashable`.
struct IncidentMediaModel: Identifiable, Hashable {
    /// Unique identifier of the media.
    let id: String

    /// The MIME type of the media (e.g., `"image/jpeg"`, `"video/mp4"`).
    let mimeType: String?

    /// The URL of the media resource.
    let url: String?

    /// The type of media represented by an integer value
    /// (e.g., `0` for image, `1` for video, depending on API definition).
    let type: Int?

    /// Identifier of the incident this media belongs to.
    let incidentId: String?

    /// Creates a new `IncidentMediaModel` instance.
    ///
    /// - Parameters:
    ///   - id: Unique identifier of the media.
    ///   - mimeType: MIME type of the media.
    ///   - url: URL of the media resource.
    ///   - type: Media type as an integer.
    ///   - incidentId: Identifier of the incident this media belongs to.
    init(
        id: String,
        mimeType: String?,
        url: String?,
        type: Int?,
        incidentId: String?
    ) {
        self.id = id
        self.mimeType = mimeType
        self.url = url
        self.type = type
        self.incidentId = incidentId
    }
}
