//
//  UserModel.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - UserModel

/// Represents a user entity within the application.
///
/// This model is part of the domain/UI layer and is designed
/// to be safe (non-optional properties) and easy to use in SwiftUI
/// since it conforms to `Identifiable` and `Hashable`.
struct UserModel: Identifiable, Hashable {
    /// Unique identifier of the user.
    let id: String

    /// The user's email address.
    let email: String?

    /// The one-time password (OTP) associated with the user, if applicable.
    let otp: String?

    /// Authentication token for the user session.
    let token: String?

    /// The timestamp when the user was created (ISO-8601 formatted).
    let createdAt: Date?

    /// The timestamp when the user was last updated (ISO-8601 formatted).
    let updatedAt: Date?

    /// The roles assigned to the user.
    let roles: [UserRoleModel]

    /// Creates a new `UserModel` instance.
    ///
    /// - Parameters:
    ///   - id: Unique identifier of the user.
    ///   - email: The user's email address.
    ///   - otp: The one-time password associated with the user.
    ///   - token: Authentication token for the user session.
    ///   - createdAt: Timestamp string when the user was created.
    ///   - updatedAt: Timestamp string when the user was last updated.
    ///   - roles: A collection of roles assigned to the user.
    init(
        id: String,
        email: String,
        otp: String,
        token: String,
        createdAt: Date?,
        updatedAt: Date?,
        roles: [UserRoleModel]
    ) {
        self.id = id
        self.email = email
        self.otp = otp
        self.token = token
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.roles = roles
    }
}
