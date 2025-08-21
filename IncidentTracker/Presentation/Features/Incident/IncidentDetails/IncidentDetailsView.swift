//
//  IncidentDetailsView.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import SwiftUI

// MARK: - IncidentDetailsView

/// A detail screen that displays comprehensive information about a single incident.
///
/// Features:
/// - Displays the incident’s primary image with a status badge overlay.
/// - Shows creation and update timestamps.
/// - Displays the incident description.
/// - Toolbar actions:
///   - Open the incident location in Apple Maps (if available).
///   - Present a status filter sheet to update the incident status.
struct IncidentDetailsView: View {
    /// The view model providing incident details and update logic.
    @StateObject var viewModel: IncidentDetailsViewModel

    /// App-wide router environment object for navigation control.
    @EnvironmentObject var appRouter: AppRouter

    /// Controls whether the status filter sheet is displayed.
    @State private var showingStatusSheet = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                // MARK: - Incident Image + Status Badge

                AsyncImageView(viewModel.imageURL)
                    .frame(height: 200)
                    .overlay(alignment: .topTrailing) {
                        Text(viewModel.statusName)
                            .font(.caption)
                            .bold()
                            .padding(4)
                            .background {
                                Capsule().fill(Color.orange)
                            }
                            .padding(10)
                    }

                // MARK: - Timestamps + Description

                VStack(alignment: .leading, spacing: 16) {
                    VStack(spacing: 6) {
                        HStack {
                            Text("Created at:")
                                .font(.caption)
                                .foregroundStyle(.secondary)

                            Text(viewModel.createdAt)
                                .font(.caption)
                                .bold()
                        }

                        HStack {
                            Text("Updated at:")
                                .font(.caption)
                                .foregroundStyle(.secondary)

                            Text(viewModel.updatedAt)
                                .font(.caption)
                                .bold()
                        }
                    }

                    Text(viewModel.description)
                        .font(.body)
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.leading)
                }
                .padding(16)
            }
        }

        // MARK: - Toolbar

        .toolbar {
            // Title in center
            ToolbarItem(placement: .principal) {
                Text("Incidents")
                    .font(.headline)
            }

            // Open map if coordinates are available
            if viewModel.canOpenMap {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        guard let latitude = viewModel.latitude,
                              let longitude = viewModel.longitude else {
                            return
                        }
                        openMap(latitude: latitude, longitude: longitude)
                    } label: {
                        Image(systemName: "location.circle.fill")
                            .foregroundStyle(Color.white)
                    }
                }
            }

            // Open status filter sheet
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingStatusSheet = true
                } label: {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .foregroundStyle(Color.white)
                }
            }
        }
        // Show toast messages from the view model
        .toast($viewModel.message)
        // Show loading indicator while fetching/updating
        .loading(isLoading: viewModel.isLoading)
        // Navigation title
        .navigationTitle("Incident Details")
        .navigationBarTitleDisplayMode(.inline)
        // Present status filter sheet
        .sheet(isPresented: $showingStatusSheet) {
            StatusFilterView(selectedStatus: $viewModel.status)
                .presentationDetents([.height(230)])
        }
        // React to status changes and update incident if changed
        .onChange(of: viewModel.status) { oldValue, newValue in
            guard oldValue != newValue else { return }
            viewModel.updateStatus()
        }
    }
}

// MARK: - Preview

#Preview {
    let useCase = IncidentDetailsUseCase(incidentRepository: IncidentRepository())
    let viewModel = IncidentDetailsViewModel(
        incident: .mock,
        incidentDetailsUseCase: useCase
    )

    NavigationStack {
        IncidentDetailsView(viewModel: viewModel)
            .preferredColorScheme(.dark)
    }
}
