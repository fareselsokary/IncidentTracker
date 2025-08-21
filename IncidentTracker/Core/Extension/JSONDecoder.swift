//
//  JSONDecoder.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

extension JSONDecoder {
    /// Creates a `JSONDecoder` instance configured to decode
    /// ISO8601 date strings with fractional seconds and a `Z` timezone suffix.
    ///
    /// Example of supported format:
    /// ```
    /// "2021-12-28T18:44:55.596Z"
    /// ```
    static func iso8601WithMillisecondsDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()

        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }

    /// Creates a `JSONDecoder` instance configured to decode
    /// date strings in the format `yyyy-MM-dd HH:mm:ss`.
    ///
    /// Example of supported format:
    /// ```
    /// "2020-12-30 07:30:00"
    /// ```
    static func simpleDateTimeDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()

        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }
}
