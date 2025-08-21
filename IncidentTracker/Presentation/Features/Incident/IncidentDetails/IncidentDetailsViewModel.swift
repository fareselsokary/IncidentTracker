//
//  IncidentDetailsViewModel.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import Foundation

// MARK: - IncidentDetailsViewModel

/// A view model that manages the state and business logic for displaying
/// and updating the details of a single incident.
///
/// Responsibilities:
/// - Exposes the incident’s details in a presentation-friendly format.
/// - Handles updating the incident status through the use case.
/// - Publishes UI states such as loading and error messages.
class IncidentDetailsViewModel: ObservableObject {
    // MARK: - Published Properties

    /// A flag indicating whether data is currently being loaded (e.g., when updating status).
    @Published var isLoading: Bool = false

    /// A message to be displayed to the user (e.g., error or success messages).
    @Published var message: ToastMessage?

    /// The incident currently being displayed.
    @Published var incident: Incident

    /// The current status of the incident.
    /// This can be changed by the user through the UI (status filter).
    @Published var status: IncidentsStatus?

    // MARK: - Private Properties

    /// The use case responsible for retrieving and updating incident details.
    private let incidentDetailsUseCase: IncidentDetailsUseCaseProtocol

    // MARK: - Initialization

    /// Initializes the view model with the given incident and use case.
    ///
    /// - Parameters:
    ///   - incident: The incident to display.
    ///   - incidentDetailsUseCase: The use case handling incident details operations.
    init(incident: Incident, incidentDetailsUseCase: IncidentDetailsUseCaseProtocol) {
        self.incident = incident
        self.incidentDetailsUseCase = incidentDetailsUseCase
        status = incident.status
    }
}

// MARK: - Status Updates

extension IncidentDetailsViewModel {
    /// Updates the status of the incident using the provided use case.
    /// If `status` is `nil`, this operation does nothing.
    func updateStatus() {
        guard let status else { return }
        Task { @MainActor in
            do {
                defer { isLoading = false }
                isLoading = true
                let _ = try await incidentDetailsUseCase.changeIncidentStatus(
                    id: incident.id,
                    status: status.rawValue
                )
            } catch {
                message = .error(error.localizedDescription)
            }
        }
    }
}

// MARK: - Computed Presentation Properties

extension IncidentDetailsViewModel {
    /// Returns the URL of the first media item of the incident, if available.
    var imageURL: URL? {
        URL(string: incident.media.first?.url ?? "")
    }

    /// Returns the formatted creation date of the incident.
    /// If unavailable, returns an empty string.
    var createdAt: String {
        incident.createdAt?.toString(formatter: .simpleDateTime) ?? ""
    }

    /// Returns the formatted last updated date of the incident.
    /// If unavailable, returns an empty string.
    var updatedAt: String {
        incident.updatedAt?.toString(formatter: .simpleDateTime) ?? ""
    }

    /// Returns the localized name of the incident’s status.
    /// If unavailable, returns an empty string.
    var statusName: String {
        status?.name ?? ""
    }

    /// Returns the incident’s description.
    /// If unavailable, returns an empty string.
    var description: String {
        incident.description ?? ""
    }

    /// Whether the incident contains valid coordinates for map navigation.
    var canOpenMap: Bool {
        incident.latitude != nil && incident.longitude != nil
    }

    /// The latitude coordinate of the incident, if available.
    var latitude: Double? {
        incident.latitude
    }

    /// The longitude coordinate of the incident, if available.
    var longitude: Double? {
        incident.longitude
    }
}
