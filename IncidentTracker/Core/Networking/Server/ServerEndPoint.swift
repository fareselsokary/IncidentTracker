//
//  ServerEndPoint.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

/// Defines all server endpoint paths used in the application.
///

enum ServerEndPoint {
    // MARK: - Auth

    /// Authentication-related endpoints.
    enum Auth {
        /// Logs a user in with credentials
        static let login = "login"

        /// Verifies a one-time password (OTP) for authentication.
        static let verifyOTP = "verify-otp"
    }

    // MARK: - Incident

    /// Incident reporting and management endpoints.
    enum Incident {
        /// Fetches available incident types.
        static let types = "types"

        /// Retrieves a list of incidents.
        static let list = "incident"

        /// Submits a new incident report.
        static let submit = "incident"

        /// Uploads an image related to an incident.
        ///
        /// - Note: Use `String(format:)` to inject the incident ID.
        /// Example:
        /// ```swift
        /// let path = String(format: ServerEndPoint.Incident.uploadImage, "123")
        /// ```
        static let uploadImage = "incident/upload/%@"

        /// Updates the status of an incident
        static let changeStatus = "incident/change-status"
    }

    // MARK: - Worker Tracking

    /// Worker/bus tracking endpoints.
    enum WorkerTracking {
        /// Submits the current bus/worker tracking location.
        static let submitTrack = "buses/track-bus"

        /// Retrieves a list of tracked bus/worker locations.
        static let trackList = "buses/track-bus"
    }

    // MARK: - User

    /// User management endpoints.
    enum User {
        /// Retrieves a list of users.
        static let list = "user"
    }

    // MARK: - Dashboard

    /// Dashboard-related endpoints.
    enum Dashboard {
        /// Fetches dashboard summary/details data.
        static let details = "dashboard"
    }
}
