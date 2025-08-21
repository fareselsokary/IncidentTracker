//
//  UserRoleMapper.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - UserRoleMapper

/// A utility responsible for mapping API response models (`UserRoleResponse`)
/// into domain/UI models (`UserRoleModel`).
enum UserRoleMapper {
    /// Maps a single `UserRoleResponse` into a `UserRoleModel`.
    ///
    /// - Parameter response: The API response object representing a user role.
    /// - Returns: A `UserRoleModel` domain object.
    static func map(_ response: UserRoleResponse) -> UserRoleModel {
        return UserRoleModel(
            id: response.id,
            type: response.type,
            userId: response.userId
        )
    }

    /// Maps an array of `UserRoleResponse` objects into an array of `UserRoleModel` objects.
    ///
    /// - Parameter responses: A list of API response roles.
    /// - Returns: A list of mapped `UserRoleModel` domain objects.
    static func mapList(_ responses: [UserRoleResponse]) -> [UserRoleModel] {
        return responses.map { map($0) }
    }
}

// MARK:
