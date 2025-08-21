//
//  UserRoleModel.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - UserRoleModel

/// Represents a role assigned to a user within the application.
///
/// A `UserRoleModel` defines the type of role (e.g., admin, worker, viewer),
/// and links it to the user that owns the role.
struct UserRoleModel: Identifiable, Hashable {
    
    /// Unique identifier of the user role.
    let id: String
    
    /// The role type (raw integer value).
    ///
    /// Typically mapped to an enum describing role categories.
    let type: Int?

    /// The identifier of the user who owns this role.
    let userId: String?

    /// Creates a new `UserRoleModel` instance.
    ///
    /// - Parameters:
    ///   - id: Unique identifier of the user role.
    ///   - type: The role type as an integer.
    ///   - userId: The identifier of the user who owns this role.
    init(
        id: String,
        type: Int?,
        userId: String?
    ) {
        self.id = id
        self.type = type
        self.userId = userId
    }
}
