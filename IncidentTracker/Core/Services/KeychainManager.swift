//
//  KeychainManager.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import KeychainSwift

// MARK: - KeychainServiceProtocol

/// Defines a set of operations for storing, retrieving, and deleting
/// sensitive data in the Keychain.
///
/// This protocol allows you to abstract away the concrete Keychain implementation
/// for easier testing and flexibility.
protocol KeychainServiceProtocol {
    /// Saves a string value in the Keychain for a given key.
    /// - Parameters:
    ///   - value: The string value to store securely.
    ///   - key: The key under which the value will be stored.
    func save(_ value: String, for key: String)

    /// Reads a string value from the Keychain for a given key.
    /// - Parameter key: The key used to retrieve the value.
    /// - Returns: The stored string if it exists, otherwise `nil`.
    func read(for key: String) -> String?

    /// Deletes a value from the Keychain for a given key.
    /// - Parameter key: The key whose value should be deleted.
    func delete(for key: String)
}

// MARK: - KeychainManager

/// A concrete implementation of `KeychainServiceProtocol` using `KeychainSwift`.
///
/// This class provides a simple API to store, retrieve, and delete
/// sensitive data such as authentication tokens in the Keychain.
/// It supports iCloud Keychain synchronization by default.
final class KeychainManager: KeychainServiceProtocol {
    /// The underlying KeychainSwift instance used for actual storage.
    private let keychain: KeychainSwift

    /// Initializes a new `KeychainManager`.
    /// - Parameter keychain: An optional `KeychainSwift` instance. Defaults to a new instance.
    init(keychain: KeychainSwift = KeychainSwift()) {
        self.keychain = keychain
        self.keychain.synchronizable = true // Enable iCloud Keychain sync
    }

    /// Saves a string value in the Keychain for a given key.
    /// - Parameters:
    ///   - value: The string value to store securely.
    ///   - key: The key under which the value will be stored.
    func save(_ value: String, for key: String) {
        keychain.set(value, forKey: key, withAccess: .accessibleWhenUnlocked)
    }

    /// Reads a string value from the Keychain for a given key.
    /// - Parameter key: The key used to retrieve the value.
    /// - Returns: The stored string if it exists, otherwise `nil`.
    func read(for key: String) -> String? {
        keychain.get(key)
    }

    /// Deletes a value from the Keychain for a given key.
    /// - Parameter key: The key whose value should be deleted.
    func delete(for key: String) {
        keychain.delete(key)
    }
}
