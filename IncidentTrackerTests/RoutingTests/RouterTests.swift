//
//  RouterTests.swift
//  podcastTests
//
//  Created by Tests on 18/08/2025.
//

import XCTest
import SwiftUI
@testable import IncidentTracker

final class RouterTests: XCTestCase {
    func testPushAppendsDestinationToPath() {
        // Arrange
        let router = AppRouter()
        XCTAssertEqual(router.navigationPath.count, 0)

        // Act
        router.push(destination: .addIncident)

        // Assert
        XCTAssertEqual(router.navigationPath.count, 1)
    }

    func testPopRemovesLastDestination() {
        // Arrange
        let router = AppRouter()
        router.push(destination: .addIncident)
        XCTAssertEqual(router.navigationPath.count, 1)

        // Act
        router.pop()

        // Assert
        XCTAssertEqual(router.navigationPath.count, 0)
    }

    func testPopToRootClearsPath() {
        // Arrange
        let router = AppRouter()
        router.push(destination: .addIncident)
        router.push(destination: .addIncident)
        XCTAssertEqual(router.navigationPath.count, 2)

        // Act
        router.popToRoot()

        // Assert
        XCTAssertEqual(router.navigationPath.count, 0)
    }
}


