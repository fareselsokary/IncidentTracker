//
//  VerificationResponse.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - VerificationResponse

struct VerificationResponse: Codable {
    let token: String?
    let roles: [Int]?

    init(token: String?, roles: [Int]?) {
        self.token = token
        self.roles = roles
    }

    enum CodingKeys: String, CodingKey {
        case token
        case roles
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        token = try container.decodeIfPresent(String.self, forKey: .token)
        roles = try container.decodeIfPresent([Int].self, forKey: .roles)
    }
}
