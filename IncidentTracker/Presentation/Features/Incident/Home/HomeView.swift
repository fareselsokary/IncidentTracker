//
//  HomeView.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import SwiftUI

// MARK: - HomeView

/// The main view displaying a dashboard of incidents and related charts.

struct HomeView: View {
    /// The view model providing chart data, incident data, and filtering logic.
    @StateObject var viewModel: HomeViewModel

    /// App-wide router environment object for navigation.
    @EnvironmentObject var appRouter: AppRouter

    @EnvironmentObject var sessionManager: SessionManager

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // MARK: - Chart View

                /// Displays the chart of incidents at the top of the screen.
                ChartView(chartData: viewModel.chartData)
                    .padding(.all, 16)
                    .background(Color.gray.opacity(0.2))
                    .shadow(radius: 5)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .frame(height: 200)

                Divider()
            }
            // Only render chart section if there are data points
            .renderedIf(!viewModel.chartData.dataPoints.isEmpty)

            // MARK: - Incident List

            /// LazyVStack for displaying filtered incidents with pinned filter header.
            LazyVStack(
                alignment: .center,
                spacing: 8,
                pinnedViews: [.sectionHeaders]
            ) {
                Section {
                    // Render incident cards for filtered incidents
                    ForEach(viewModel.filteredIncidents, id: \.id) { incident in
                        IncidentCardView(viewModel: IncidentCardViewModel(incident: incident))
                            .onTapGesture {
                                appRouter.push(destination: .incidentDetails(incident))
                            }
                    }
                } header: {
                    // Filter header for status and date
                    IncidentFilterView(
                        status: $viewModel.statusFilter,
                        date: $viewModel.dateFilter
                    )
                }
                // Conditionally render the section based on showIncidents flag
                .renderedIf(viewModel.showIncidents)
            }
        }
        // Apply vertical and horizontal content margins
        .contentMargins(.vertical, 8, for: .scrollContent)
        .contentMargins(.horizontal, 16, for: .scrollContent)
        // Show toast messages
        .toast($viewModel.message)
        // Show loading indicator if needed
        .loading(isLoading: viewModel.isLoading)
        // Navigation title
        // .navigationTitle("Incidents")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Incidents")
                    .font(.headline)
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    appRouter.push(destination: .addIncident)
                }) {
                    Image(systemName: "plus.circle")
                        .foregroundStyle(Color.white)
                }
            }

            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    sessionManager.clear()
                }) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .foregroundStyle(Color.white)
                }
            }
        }
        // Trigger data loading when the view appears
        .onAppear(perform: viewModel.loadData)
    }
}

// MARK: - Preview

#Preview {
    let useCase = HomeUseCase(
        dashboardRepository: DashboardRepository(),
        incidentRepository: IncidentRepository()
    )
    let viewModel = HomeViewModel(homeUseCase: useCase)
    HomeView(viewModel: viewModel)
}
