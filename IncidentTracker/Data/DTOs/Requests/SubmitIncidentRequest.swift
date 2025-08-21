//
//  SubmitIncidentRequest.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

// MARK: - UserResponse

struct SubmitIncidentRequest: Encodable {
    let description: String
    let latitude: Double
    let longitude: Double
    let status: Int
    let typeId: Int
    let priority: Int?
    let issuerId: String?

    init(
        description: String,
        latitude: Double,
        longitude: Double,
        status: Int,
        typeId: Int,
        priority: Int? = nil,
        issuerId: String? = nil
    ) {
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        self.status = status
        self.typeId = typeId
        self.priority = priority
        self.issuerId = issuerId
    }

    enum CodingKeys: String, CodingKey {
        case description
        case latitude
        case longitude
        case status
        case typeId
        case priority
        case issuerId
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(latitude, forKey: .latitude)
        try container.encodeIfPresent(longitude, forKey: .longitude)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(typeId, forKey: .typeId)
        try container.encodeIfPresent(priority, forKey: .priority)
        try container.encodeIfPresent(issuerId, forKey: .issuerId)
    }
}
