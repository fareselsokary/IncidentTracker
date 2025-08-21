//
//  SessionManagerTests.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

@testable import IncidentTracker
import XCTest

// MARK: - SessionManagerTests

final class SessionManagerTests: XCTestCase {
    func testInitWithNoSavedSessionStartsLoggedOut() {
        let keychain = MockKeychainService()
        let session = SessionManager(keychain: keychain)

        XCTAssertFalse(session.isLoggedIn)
        XCTAssertNil(session.token)
    }

    func testInitWithSavedTokenStartsLoggedIn() {
        let keychain = MockKeychainService()
        keychain.save("existing_token", for: KeychainKeys.userToken)

        let session = SessionManager(keychain: keychain)

        XCTAssertTrue(session.isLoggedIn)
        XCTAssertEqual(session.token, "existing_token")
    }

    func testSaveTokenUpdatesLoginStateAndPersists() {
        let keychain = MockKeychainService()
        let session = SessionManager(keychain: keychain)

        session.saveToken("new_token")

        XCTAssertTrue(session.isLoggedIn)
        XCTAssertEqual(session.token, "new_token")
        XCTAssertEqual(keychain.read(for: KeychainKeys.userToken), "new_token")
    }

    func testClearRemovesTokenAndLogsOut() {
        let keychain = MockKeychainService()
        let session = SessionManager(keychain: keychain)

        session.saveToken("temp_token")
        session.clear()

        XCTAssertFalse(session.isLoggedIn)
        XCTAssertNil(session.token)
        XCTAssertNil(keychain.read(for: KeychainKeys.userToken))
    }
}
