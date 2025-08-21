//
//  IncidentMediaResponse.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - IncidentMediaResponse

struct IncidentMediaResponse: Decodable {
    let id: String
    let mimeType: String?
    let url: String?
    let type: Int?
    let incidentId: String?

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

    enum CodingKeys: String, CodingKey {
        case id
        case mimeType
        case url
        case type
        case incidentId
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        mimeType = try container.decodeIfPresent(String.self, forKey: .mimeType)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        type = try container.decodeIfPresent(Int.self, forKey: .type)
        incidentId = try container.decodeIfPresent(String.self, forKey: .incidentId)
    }
}
