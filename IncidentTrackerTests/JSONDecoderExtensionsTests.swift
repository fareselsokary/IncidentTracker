//
//  IncidentTrackerTests.swift
//  IncidentTrackerTests
//
//  Created by fares on 21/08/2025.
//

@testable import IncidentTracker
import XCTest

// MARK: - Event

private struct Event: Codable, Equatable {
    let name: String
    let date: Date
}

// MARK: - JSONDecoderExtensionsTests

final class JSONDecoderExtensionsTests: XCTestCase {
    func testISO8601WithMillisecondsDecoder() throws {
        // Given
        let json = """
        {
            "name": "Launch",
            "date": "2021-12-28T18:44:55.596Z"
        }
        """.data(using: .utf8)!

        // When
        let decoder = JSONDecoder.iso8601WithMillisecondsDecoder()
        let event = try decoder.decode(Event.self, from: json)

        // Then
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(
            in: TimeZone(secondsFromGMT: 0)!,
            from: event.date
        )

        XCTAssertEqual(event.name, "Launch")
        XCTAssertEqual(components.year, 2021)
        XCTAssertEqual(components.month, 12)
        XCTAssertEqual(components.day, 28)
        XCTAssertEqual(components.hour, 18)
        XCTAssertEqual(components.minute, 44)
        XCTAssertEqual(components.second, 55)
    }

    func testSimpleDateTimeDecoder() throws {
        // Given
        let json = """
        {
            "name": "Meeting",
            "date": "2020-12-30 07:30:00"
        }
        """.data(using: .utf8)!

        // When
        let decoder = JSONDecoder.simpleDateTimeDecoder()
        let event = try decoder.decode(Event.self, from: json)

        // Then
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(
            in: TimeZone(secondsFromGMT: 0)!,
            from: event.date
        )

        XCTAssertEqual(event.name, "Meeting")
        XCTAssertEqual(components.year, 2020)
        XCTAssertEqual(components.month, 12)
        XCTAssertEqual(components.day, 30)
        XCTAssertEqual(components.hour, 7)
        XCTAssertEqual(components.minute, 30)
        XCTAssertEqual(components.second, 0)
    }

    func testInvalidDateFormatFails() {
        // Given
        let json = """
        {
            "name": "BadEvent",
            "date": "30/12/2020 07:30:00"
        }
        """.data(using: .utf8)!

        // When
        let decoder = JSONDecoder.simpleDateTimeDecoder()

        // Then
        XCTAssertThrowsError(try decoder.decode(Event.self, from: json))
    }
}
