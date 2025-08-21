//
//  UserMapper.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - UserMapper

/// A utility responsible for mapping API response models (`UserResponse`)
/// into domain/UI models (`UserModel`).
enum UserMapper {
    /// Maps a single `UserResponse` into a `UserModel`.
    ///
    /// - Parameter response: The API response object representing a user.
    /// - Returns: A `UserModel` domain object.
    static func map(_ response: UserResponse) -> UserModel {
        return UserModel(
            id: response.id,
            email: response.email ?? "",
            otp: response.otp ?? "",
            token: response.token ?? "",
            createdAt: response.createdAt,
            updatedAt: response.updatedAt,
            roles: UserRoleMapper.mapList(response.roles ?? [])
        )
    }

    /// Maps an array of `UserResponse` objects into an array of `UserModel` objects.
    ///
    /// - Parameter responses: A list of API response users.
    /// - Returns: A list of mapped `UserModel` domain objects.
    static func mapList(_ responses: [UserResponse]) -> [UserModel] {
        return responses.map { map($0) }
    }
}
