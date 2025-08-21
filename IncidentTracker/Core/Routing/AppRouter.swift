//
//  AppRouter.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import SwiftUI

// MARK: - AppRouter

/// `AppRouter` is a concrete implementation of the `Router` protocol.
/// It manages navigation in a SwiftUI `NavigationStack` and can be injected
/// into Views and ViewModels via `@EnvironmentObject`.
///
/// This class supports hierarchical navigation (push/pop), pop-to-root,
/// and replacing the navigation stack with a new root destination.
/// It also handles modal navigation through the `currentDestination` property.
class AppRouter: Router {
    /// The currently active modal navigation destination (e.g., for sheets or full-screen covers).
    ///
    /// Setting this property to a non-nil value will trigger a modal presentation in the view.
    /// Setting it back to `nil` will dismiss the modal.
    @Published var currentDestination: NavigationDestination? = nil

    /// The navigation stack state used in a `NavigationStack`.
    ///
    /// This is updated as destinations are pushed or popped. Resetting this property
    /// to an empty `NavigationPath` returns the navigation to the root.
    @Published var navigationPath = NavigationPath()

    /// Initializes a new instance of `AppRouter`.
    ///
    /// Typically injected into SwiftUI views via `@EnvironmentObject`.
    init() {}

    // MARK: - Router Protocol Conformance

    /// Pushes a new destination onto the navigation stack.
    ///
    /// - Parameter destination: The `NavigationDestination` to push onto the stack.
    /// Use this to navigate forward to a new view in a `NavigationStack`.
    func push(destination: NavigationDestination) {
        navigationPath.append(destination)
    }

    /// Pops the top view from the navigation stack.
    ///
    /// Removes the last destination from the stack, effectively navigating back one level.
    func pop() {
        guard !navigationPath.isEmpty else { return }
        navigationPath.removeLast()
    }

    /// Pops all views from the navigation stack back to the root.
    ///
    /// Clears the entire `NavigationPath`, returning the user to the root view.
    func popToRoot() {
        navigationPath = NavigationPath()
    }

    /// Replaces the entire navigation stack with a new root destination.
    ///
    /// - Parameter destination: The new root `NavigationDestination` to display.
    ///
    /// This clears any previous navigation history and starts a new stack
    /// with the specified destination at the root.
    func setRoot(destination: NavigationDestination) {
        navigationPath = NavigationPath()
        navigationPath.append(destination)
    }
}
