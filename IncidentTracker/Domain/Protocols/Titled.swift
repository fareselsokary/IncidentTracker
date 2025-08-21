//
//  Titled.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

// MARK: - Titled

/// A protocol that defines a common interface for any type
/// that can provide a human-readable title string.
///
/// Conformance Example:
/// ```swift
/// struct Movie: Titled {
///     let title: String
/// }
///
/// let movie = Movie(title: "Inception")
/// print(movie.title) // "Inception"
/// ```
protocol Titled {
    /// A human-readable title that represents the conforming instance.
    var title: String { get }
}
