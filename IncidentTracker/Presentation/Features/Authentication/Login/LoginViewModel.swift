//
//  LoginViewModel.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - LoginViewModel

/// ViewModel responsible for managing the login screen state and actions.
///
/// Handles user input, login request execution, loading state, and error messages.
/// Uses a `LoginUseCaseProtocol` to perform the actual login operation.
class LoginViewModel: ObservableObject {
    /// The email address entered by the user.
    @Published var email: String = ""

    /// Indicates whether a login request is currently in progress.
    @Published var isLoading: Bool = false

    /// Indicates whether the user is successfully logged in.
    @Published private(set) var isLoggedIn: Bool = false

    /// Holds the current toast message to be displayed, typically for errors or success messages.
    @Published var message: ToastMessage?

    /// The use case responsible for performing the login operation.
    private let loginUseCase: LoginUseCaseProtocol

    /// Initializes the `LoginViewModel` with a login use case.
    /// - Parameter loginUseCase: The use case responsible for login operations.
    init(loginUseCase: LoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase
    }
}

// MARK: - Login Action

extension LoginViewModel {
    /// Attempts to log in the user using the provided email.
    ///
    /// Updates `isLoading` during the operation.
    /// On success, sets `isLoggedIn` to true.
    /// On failure, sets `message` with the error description.
    func login() {
        Task { @MainActor in
            defer { isLoading = false }
            isLoading = true
            do {
                try await loginUseCase.login(email: email)
                isLoggedIn = true
            } catch {
                message = .error(error.localizedDescription)
            }
        }
    }
}

// MARK: - Computed Properties

extension LoginViewModel {
    /// Determines whether the login button should be enabled.
    ///
    /// Returns `true` if the email is non-empty, valid, and no login request is in progress.
    var canLogin: Bool {
        !email.isEmpty && email.isValidEmail && !isLoading
    }
}
