//
//  JSONEncoder.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

extension JSONEncoder {
    /// Encodes an Encodable object into a `[String: Any]` dictionary.
    /// Uses the encoder's current `dateEncodingStrategy`.
    func encodeToDictionary<T: Encodable>(_ value: T) throws -> [String: Any] {
        let data = try encode(value)
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])

        guard let dictionary = jsonObject as? [String: Any] else {
            throw EncodingError.invalidValue(
                value,
                EncodingError.Context(
                    codingPath: [],
                    debugDescription: "Top-level object is not a dictionary"
                )
            )
        }
        return dictionary
    }
}
