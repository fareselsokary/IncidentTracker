//
//  IncidentResponse.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - IncidentResponse

struct IncidentResponse: Decodable {
    let id: String
    let description: String?
    let latitude: Double?
    let longitude: Double?
    let status: Int?
    let priority: Int?
    let typeId: Int?
    let issuerId: String?
    let assigneeId: String?
    let createdAt: Date?
    let updatedAt: Date?
    let media: [IncidentMediaResponse]?

    init(
        id: String,
        description: String?,
        latitude: Double?,
        longitude: Double?,
        status: Int?,
        priority: Int?,
        typeId: Int?,
        issuerId: String?,
        assigneeId: String?,
        createdAt: Date?,
        updatedAt: Date?,
        media: [IncidentMediaResponse]?
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

    enum CodingKeys: String, CodingKey {
        case id
        case description
        case latitude
        case longitude
        case status
        case priority
        case typeId
        case issuerId
        case assigneeId
        case createdAt
        case updatedAt
        case media = "medias"
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
        status = try container.decodeIfPresent(Int.self, forKey: .status)
        priority = try container.decodeIfPresent(Int.self, forKey: .priority)
        typeId = try container.decodeIfPresent(Int.self, forKey: .typeId)
        issuerId = try container.decodeIfPresent(String.self, forKey: .issuerId)
        assigneeId = try container.decodeIfPresent(String.self, forKey: .assigneeId)
        createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        media = try container.decodeIfPresent([IncidentMediaResponse].self, forKey: .media)
    }
}
