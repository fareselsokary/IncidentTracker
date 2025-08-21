//
//  HomeViewModel.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import Foundation

// MARK: - HomeViewModel

/// ViewModel responsible for managing the state and data for the Home screen.
///
/// This includes fetching dashboard statistics, incidents, and providing filtered views
/// of incidents based on user-selected filters. The ViewModel also handles loading states
/// and displaying messages to the user.
class HomeViewModel: ObservableObject {
    // MARK: - Published Properties
    /// A flag indicating whether data is currently being loaded.
    @Published var isLoading: Bool = false

    /// A message to be displayed to the user (e.g., error or success messages).
    @Published var message: ToastMessage?

    /// The full list of incidents retrieved from the backend.
    @Published private var incidents: [Incident] = []

    /// The list of dashboard statistics retrieved from the backend.
    @Published private var dashboardStatistics: [DashboardIncidentModel] = []

    /// The currently selected status filter for incidents.
    @Published var statusFilter: IncidentsStatus?

    /// The currently selected date filter for incidents.
    @Published var dateFilter: Date?

    // MARK: - Private Properties

    /// The use case responsible for fetching home-related data.
    private let homeUseCase: HomeUseCaseProtocol

    // MARK: - Initialization

    /// Initializes the HomeViewModel with a specific use case.
    ///
    /// - Parameter homeUseCase: The use case that provides dashboard and incident data.
    init(homeUseCase: HomeUseCaseProtocol) {
        self.homeUseCase = homeUseCase
    }
}

// MARK: - Data Loading

extension HomeViewModel {
    /// Loads the dashboard statistics and incidents concurrently.
    ///
    /// Sets `isLoading` to `true` during loading and resets it afterwards.
    /// Handles errors by updating the `message` property.
    func loadData() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            self.isLoading = true
            defer { self.isLoading = false }

            await withTaskGroup(of: Void.self) { group in
                group.addTask { [weak self] in
                    await self?.getDashboard()
                }
                group.addTask { [weak self] in
                    await self?.getIncidents()
                }
            }
        }
    }
}

// MARK: - Private Data Fetching

private extension HomeViewModel {
    /// Fetches dashboard statistics from the use case and updates `dashboardStatistics`.
    ///
    /// Displays an error message if fetching fails.
    @MainActor
    func getDashboard() async {
        do {
            dashboardStatistics = try await homeUseCase.getDashboard()
        } catch {
            message = .error(error.localizedDescription)
        }
    }

    /// Fetches incidents from the use case and updates `incidents`.
    ///
    /// Displays an error message if fetching fails.
    @MainActor
    func getIncidents() async {
        do {
            incidents = try await homeUseCase.getIncidents()
        } catch {
            message = .error(error.localizedDescription)
        }
    }
}

// MARK: - Computed Properties

extension HomeViewModel {
    /// Returns the chart data constructed from `dashboardStatistics`.
    var chartData: ChartData {
        ChartData(
            dataPoints: dashboardStatistics.compactMap { ChartDataPoint(
                label: $0.status.name,
                value: Double($0.count)
            ) }
        )
    }

    /// Returns the list of incidents filtered by the selected date and/or status.
    ///
    /// Filtering behavior:
    /// - **Date Filter (`dateFilter`)**:
    ///   - If `dateFilter` is `nil`, incidents are **not filtered by date**.
    ///   - If `dateFilter` is set, incidents are filtered to only include those
    ///     whose `createdAt` date exists and matches the `dateFilter` **on the same calendar day**, ignoring the time component.
    ///   - If an incident's `createdAt` is `nil` and `dateFilter` is set, the incident is **excluded**.
    /// - **Status Filter (`statusFilter`)**:
    ///   - If `statusFilter` is `nil`, incidents are **not filtered by status**.
    ///   - If `statusFilter` is set, only incidents with a matching `status` are included.
    /// - If **both filters are `nil`**, all incidents are returned.
    /// - If **both filters are set**, only incidents matching **both** the date and status are returned.
    var filteredIncidents: [Incident] {
        let calendar = Calendar.current

        return incidents.filter { incident in
            // Determine if the incident matches the date filter
            let matchesDate: Bool
            if let createdAt = incident.createdAt, let dateFilter = dateFilter {
                // Compare dates by day only if both exist
                matchesDate = calendar.isDate(createdAt, inSameDayAs: dateFilter)
            } else if dateFilter == nil {
                // No date filter → include all incidents
                matchesDate = true
            } else {
                // dateFilter exists but incident has no date → exclude
                matchesDate = false
            }

            // Determine if the incident matches the status filter
            let matchesStatus = statusFilter == nil || incident.status == statusFilter

            // Include only incidents matching both filters
            return matchesDate && matchesStatus
        }
    }

    /// Indicates whether there are any incidents to show.
    var showIncidents: Bool {
        !incidents.isEmpty
    }
}
