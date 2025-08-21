//
//  UserRepositoryProtocol.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

/// Protocol defining the contract for a user repository.
///
/// Provides methods to fetch user-related data from a data source (e.g., API or local storage).
protocol UserRepositoryProtocol {
    /// Fetches the list of users.
    ///
    /// - Throws: An error if fetching the users fails (e.g., network error, decoding error).
    /// - Returns: An array of `UserResponse` representing the users retrieved from the data source.
    func getUsersList() async throws -> [UserResponse]
}
