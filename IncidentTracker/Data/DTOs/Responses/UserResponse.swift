//
//  UserResponse.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - UserResponse

struct UserResponse: Codable {
    let id: String
    let email: String?
    let otp: String?
    let token: String?
    let createdAt: Date?
    let updatedAt: Date?
    let roles: [UserRoleResponse]?

    init(
        id: String,
        email: String?,
        otp: String?,
        token: String?,
        createdAt: Date?,
        updatedAt: Date?,
        roles: [UserRoleResponse]?
    ) {
        self.id = id
        self.email = email
        self.otp = otp
        self.token = token
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.roles = roles
    }

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case otp
        case token
        case createdAt
        case updatedAt
        case roles
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        otp = try container.decodeIfPresent(String.self, forKey: .otp)
        token = try container.decodeIfPresent(String.self, forKey: .token)
        createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        roles = try container.decodeIfPresent([UserRoleResponse].self, forKey: .roles)
    }
}

// MARK: - UserRoleResponse

struct UserRoleResponse: Codable {
    let id: String
    let type: Int?
    let userId: String?

    init(
        id: String,
        type: Int?,
        userId: String?
    ) {
        self.id = id
        self.type = type
        self.userId = userId
    }

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case userId
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        type = try container.decodeIfPresent(Int.self, forKey: .type)
        userId = try container.decodeIfPresent(String.self, forKey: .userId)
    }
}
