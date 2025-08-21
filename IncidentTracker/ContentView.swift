//
//  ContentView.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import SwiftUI

// MARK: - ContentView

/// The root view of the app, responsible for handling:
/// - User authentication and session management.
/// - Navigation stack and dynamic routing based on the user's login state.
/// - Configuration of network settings.
///
/// Features:
/// - Uses `SessionManager` to determine if the user is logged in.
/// - Dynamically presents either `HomeView` (logged in) or `LoginView` (not logged in).
/// - Handles navigation to verification screens via `NavigationDestination`.
/// - Configures network headers and base URL at initialization.
/// - Updates the server authorization token whenever login state changes.
struct ContentView: View {
    /// App-wide router for navigation through the app.
    @EnvironmentObject var appRouter: AppRouter

    /// Manages user session and authentication state.
    @StateObject private var sessionManager = SessionManager(keychain: KeychainManager())

    /// Initializes the view and configures the network settings.
    init() {
        configureNetwork()
    }

    var body: some View {
        NavigationStack(path: $appRouter.navigationPath) {
            Group {
                // MARK: - Conditional Root Views

                if sessionManager.isLoggedIn {
                    // Logged-in user: show HomeView
                    let useCase = HomeUseCase(
                        dashboardRepository: DashboardRepository(),
                        incidentRepository: IncidentRepository()
                    )
                    let viewModel = HomeViewModel(homeUseCase: useCase)
                    HomeView(viewModel: viewModel)
                } else {
                    // Logged-out user: show LoginView
                    let repository = AuthenticationRepository()
                    let useCase = LoginUseCase(repository: repository)
                    let viewModel = LoginViewModel(loginUseCase: useCase)
                    LoginView(viewModel: viewModel)
                }
            }

            // MARK: - Navigation Destinations

            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case let .optVerification(email):
                    let repository = AuthenticationRepository()
                    let useCase = VerifyOTPUseCase(repository: repository)
                    let viewModel = VerificationViewModel(email: email, verifyOTPUseCase: useCase)

                    VerificationView(viewModel: viewModel)
                case .addIncident:
                    let useCase = AddIncidentUseCase(incidentRepository: IncidentRepository())
                    let viewModel = AddIncidentViewModel(addIncidentUseCase: useCase)
                    AddIncidentView(viewModel: viewModel)
                case let .incidentDetails(incident):
                    let useCase = IncidentDetailsUseCase(incidentRepository: IncidentRepository())
                    let viewModel = IncidentDetailsViewModel(
                        incident: incident,
                        incidentDetailsUseCase: useCase
                    )
                    IncidentDetailsView(viewModel: viewModel)
                }
            }
        }

        // MARK: - Session State Observer

        .onChange(of: sessionManager.isLoggedIn) { oldValue, newValue in
            guard oldValue != newValue else { return }
            // Update server authorization token when login state changes
            ServerManager.shared.updateAuthorizationToken(sessionManager.token)
            // Pop navigation stack to root after login/logout
            appRouter.popToRoot()
        }
        // Inject the session manager into the environment for child views
        .environmentObject(sessionManager)
    }
}

// MARK: - Network Configuration

extension ContentView {
    /// Configures the server manager with a base URL and default headers.
    private func configureNetwork() {
        ServerManager.shared.configure(
            baseURL: "https://ba4caf56-6e45-4662-bbfb-20878b8cd42e.mock.pstmn.io",
            headers: ["Content-Type": "application/json"]
        )
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
