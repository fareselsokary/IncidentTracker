//
//  VerificationMapper.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - UserRoleMapper

/// A utility responsible for mapping API response models (`UserRoleResponse`)
/// into domain/UI models (`UserRoleModel`).
enum VerificationMapper {
    /// Maps a single `UserRoleResponse` into a `UserRoleModel`.
    ///
    /// - Parameter response: The API response object representing a user role.
    /// - Returns: A `UserRoleModel` domain object.
    static func map(_ response: VerificationResponse) -> VerificationModel {
        return VerificationModel(
            token: response.token,
            roles: response.roles
        )
    }
}
