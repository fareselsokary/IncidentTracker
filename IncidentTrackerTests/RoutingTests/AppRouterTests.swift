//
//  AppRouterTests.swift
//  podcastTests
//
//  Created by Tests on 18/08/2025.
//

@testable import IncidentTracker
import XCTest

final class AppRouterTests: XCTestCase {
    func testCurrentDestinationPublish() {
        // Arrange
        let router = AppRouter()
        XCTAssertNil(router.currentDestination)

        // Act
        router.currentDestination = .addIncident

        // Assert
        XCTAssertEqual(router.currentDestination, .addIncident)
        XCTAssertEqual(router.currentDestination?.id, "addIncident")
    }
}
