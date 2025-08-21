//
//  IncidentListResponse.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - IncidentListResponse

struct IncidentListResponse: Decodable {
    let incidents: [IncidentResponse]?

    init(incidents: [IncidentResponse]?) {
        self.incidents = incidents
    }

    enum CodingKeys: String, CodingKey {
        case incidents
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        incidents = try container.decodeIfPresent([IncidentResponse].self, forKey: .incidents)
    }
}
