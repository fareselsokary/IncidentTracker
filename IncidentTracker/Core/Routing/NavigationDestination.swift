//
//  NavigationDestination.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import Foundation

// MARK: - NavigationDestination

/// A comprehensive enum representing all possible navigation destinations in the application.
/// Conforms to `Identifiable` and `Hashable` to be used with SwiftUI's navigation modifiers.
enum NavigationDestination: Identifiable, Hashable {
    case optVerification(email: String)
    case addIncident
    case incidentDetails(Incident)

    public var id: String {
        switch self {
        case .optVerification: return "optVerification"
        case .addIncident: return "addIncident"
        case .incidentDetails: return "incidentDetails"
        }
    }
}
