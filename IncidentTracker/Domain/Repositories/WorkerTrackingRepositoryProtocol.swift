//
//  WorkerTrackingRepositoryProtocol.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

/// Protocol defining the contract for a worker tracking repository.
///
/// Provides methods to add and fetch tracking data for workers.
protocol WorkerTrackingRepositoryProtocol {
    /// Adds a new worker tracking entry.
    ///
    /// - Parameter request: An `AddWorkerTrackingRequest` containing the details of the tracking to be added.
    /// - Throws: An error if the tracking entry cannot be added (e.g., network error, validation error).
    /// - Returns: A `TrackingResponse` containing the details of the added tracking entry.
    func addWorkerTracking(_ request: AddWorkerTrackingRequest) async throws -> TrackingResponse

    /// Retrieves all worker tracking entries.
    ///
    /// - Throws: An error if the request fails (e.g., network error, decoding error).
    /// - Returns: An array of `TrackingResponse` representing all worker tracking entries.
    func getWorkerTracking() async throws -> [TrackingResponse]
}
