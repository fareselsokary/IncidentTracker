//
//  Date.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

extension Date {
    /// Converts a Date to String using a custom formatter
    func toString(formatter: DateFormatter) -> String {
        return formatter.string(from: self)
    }
}
