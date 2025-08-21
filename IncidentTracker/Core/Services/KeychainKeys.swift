//
//  KeychainKeys.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import Foundation

/// A collection of keys used for storing and retrieving data from the Keychain.
///
/// Using a centralized enum helps avoid typos and ensures consistent key usage
/// across the app when working with sensitive data like authentication tokens.
enum KeychainKeys {
    /// The key used to store the user's authentication token in the Keychain.
    static let userToken = "userToken"
}
