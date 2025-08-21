//
//  AddIncidentViewModel.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import Combine
import Foundation

// MARK: - AddIncidentViewModel

/// A view model responsible for managing the state and logic
/// for adding a new incident.
///
/// Responsibilities:
/// - Handles fetching incident types and subtypes.
/// - Manages the selected incident details (status, type, subtype, location, description).
/// - Prepares and submits an incident request.
/// - Optionally uploads an incident image.
/// - Publishes UI state updates (loading, messages, request submission).
class AddIncidentViewModel: ObservableObject {
    // MARK: - Published Properties

    /// A flag indicating whether data is currently being loaded.
    @Published var isLoading: Bool = false

    /// A message to be displayed to the user (e.g., error or success messages).
    @Published var message: ToastMessage?

    /// The user-provided description of the incident.
    @Published var description: String = ""

    /// The selected status of the incident.
    @Published var selectedStatus: IncidentsStatus?

    /// The selected high-level type of the incident.
    @Published var selectedType: IncidentTypeModel?

    /// The selected sub-type of the incident (depends on `selectedType`).
    @Published var selectedSubType: IncidentSubTypeModel?

    /// The selected location of the incident.
    @Published var selectedLocation: LocationModel?

    /// Flag that becomes true once the request has been successfully submitted.
    @Published var isRequestSubmitted = false

    /// List of available incident types retrieved from the backend.
    @Published private(set) var incidentTypes: [IncidentTypeModel] = []

    /// List of available subtypes for the currently selected type.
    @Published private(set) var incidentSubtypes: [IncidentSubTypeModel] = []

    // MARK: - Private Properties

    /// The currently selected image data, if any, to be uploaded with the incident.
    private var selectedImageData: Data?

    /// Combine subscriptions storage.
    private var cancellables = Set<AnyCancellable>()

    /// The use case responsible for adding incidents.
    private let addIncidentUseCase: AddIncidentUseCaseProtocol

    // MARK: - Initialization

    /// Initializes the AddIncidentViewModel with a specific use case.
    ///
    /// - Parameter addIncidentUseCase: The use case that provides incident-related operations.
    init(addIncidentUseCase: AddIncidentUseCaseProtocol) {
        self.addIncidentUseCase = addIncidentUseCase
        bindData()
        loadData()
    }
}

// MARK: - Bindings

extension AddIncidentViewModel {
    /// Binds changes in `selectedType` to automatically update
    /// available subtypes and reset `selectedSubType`.
    private func bindData() {
        $selectedType
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                self?.incidentSubtypes = newValue?.subTypes ?? []
                self?.selectedSubType = nil
            }
            .store(in: &cancellables)
    }
}

// MARK: - Data Loading

extension AddIncidentViewModel {
    /// Loads the list of incident types from the backend.
    func loadData() {
        Task { @MainActor in
            do {
                defer { isLoading = false }
                isLoading = true
                incidentTypes = try await addIncidentUseCase.getIncidentsTypes()
            } catch {
                message = .error(error.localizedDescription)
            }
        }
    }

    /// Submits the incident data and uploads an image if available.
    func submitData() {
        guard let request = prepareIncidentRequest() else { return }
        Task { @MainActor in
            do {
                defer { isLoading = false }
                isLoading = true
                let _ = try await addIncidentUseCase.submitIncident(request)

                // Upload image if available (using mock ID due to API limitations).
                if let selectedImageData {
                    try await addIncidentUseCase.uploadIncidentImage(
                        id: "e172100d-60d0-4ddd",
                        imageData: selectedImageData
                    )
                }

                isRequestSubmitted = true
            } catch {
                message = .error(error.localizedDescription)
            }
        }
    }

    /// Stores the selected incident image data.
    ///
    /// - Parameter data: Raw image data to be uploaded later.
    func addImage(_ data: Data?) {
        selectedImageData = data
    }
}

// MARK: - Request Preparation

extension AddIncidentViewModel {
    /// Prepares a `SubmitIncidentRequest` if all required fields are filled.
    ///
    /// - Returns: A valid request or `nil` if required data is missing.
    private func prepareIncidentRequest() -> SubmitIncidentRequest? {
        guard let selectedStatus,
              let selectedType,
              let selectedLocation else {
            return nil
        }
        return SubmitIncidentRequest(
            description: description,
            latitude: selectedLocation.coordinate.latitude,
            longitude: selectedLocation.coordinate.longitude,
            status: selectedStatus.rawValue,
            typeId: selectedSubType?.id ?? selectedType.id
        )
    }
}

// MARK: - Validation

extension AddIncidentViewModel {
    /// Indicates whether the incident can be submitted.
    var canSubmit: Bool {
        prepareIncidentRequest() != nil
    }
}
