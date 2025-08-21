//
//  KeychainManagerTests.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

@testable import IncidentTracker
import XCTest

// MARK: - MockKeychainService

final class MockKeychainService: KeychainServiceProtocol {
    private var storage: [String: String] = [:]

    func save(_ value: String, for key: String) {
        storage[key] = value
    }

    func read(for key: String) -> String? {
        storage[key]
    }

    func delete(for key: String) {
        storage.removeValue(forKey: key)
    }
}

// MARK: - KeychainKeys

// Dummy key constants for tests
enum KeychainKeys {
    static let userToken = "userToken"
}

// MARK: - KeychainManagerTests

final class KeychainManagerTests: XCTestCase {
    func testSaveAndReadValue() {
        let keychain = MockKeychainService()

        // When
        keychain.save("my_secret_token", for: "authToken")

        // Then
        XCTAssertEqual(keychain.read(for: "authToken"), "my_secret_token")
    }

    func testDeleteValue() {
        let keychain = MockKeychainService()
        keychain.save("temp_value", for: "tempKey")

        // When
        keychain.delete(for: "tempKey")

        // Then
        XCTAssertNil(keychain.read(for: "tempKey"))
    }

    func testOverwritingValue() {
        let keychain = MockKeychainService()
        keychain.save("first_value", for: "testKey")
        keychain.save("second_value", for: "testKey")

        // Then
        XCTAssertEqual(keychain.read(for: "testKey"), "second_value")
    }

    func testReadNonExistentValueReturnsNil() {
        let keychain = MockKeychainService()

        // Then
        XCTAssertNil(keychain.read(for: "nonexistent"))
    }
}
