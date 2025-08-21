//
//  SessionManager.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import Foundation

// MARK: - SessionManagingProtocol

/// Defines the interface for managing a user session.
///
/// This protocol abstracts session handling, including storing and clearing
/// authentication tokens and providing login state information.
protocol SessionManagingProtocol {
    /// Indicates whether a user is currently logged in.
    var isLoggedIn: Bool { get }

    /// The currently stored authentication token, if available.
    var token: String? { get }

    /// Saves a new authentication token and updates the login state.
    /// - Parameter token: The authentication token to store.
    func saveToken(_ token: String)

    /// Clears the current session, including token and login state.
    func clear()
}

// MARK: - SessionManager

/// A concrete implementation of `SessionManagingProtocol` that manages
/// user authentication state using a Keychain service.
///
/// This class is `ObservableObject` so SwiftUI views can react to changes
/// in login state (`isLoggedIn`).
final class SessionManager: SessionManagingProtocol, ObservableObject {
    /// Indicates whether a user is currently logged in.
    @Published private(set) var isLoggedIn: Bool = false

    /// The currently stored authentication token, if available.
    private(set) var token: String?

    /// The underlying Keychain service used to securely store the authentication token.
    private let keychain: KeychainServiceProtocol

    /// Initializes a new `SessionManager` with a Keychain service.
    ///
    /// - Parameter keychain: The Keychain service used to store and retrieve tokens.
    /// Upon initialization, it attempts to load any previously saved session.
    init(keychain: KeychainServiceProtocol) {
        self.keychain = keychain
        loadSavedSession()
    }

    /// Loads any previously saved session from the Keychain.
    ///
    /// Updates the `isLoggedIn` property based on whether a token exists.
    private func loadSavedSession() {
        token = keychain.read(for: KeychainKeys.userToken)
        isLoggedIn = token != nil
    }

    /// Saves a new authentication token to the Keychain and updates login state.
    ///
    /// - Parameter token: The authentication token to store.
    func saveToken(_ token: String) {
        self.token = token
        keychain.save(token, for: KeychainKeys.userToken)
        isLoggedIn = true
    }

    /// Clears the current session by removing the token from the Keychain
    /// and updating the login state to `false`.
    func clear() {
        token = nil
        keychain.delete(for: KeychainKeys.userToken)
        isLoggedIn = false
    }
}
