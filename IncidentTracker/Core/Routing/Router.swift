//
//  Router.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import SwiftUI

// MARK: - Router

/// Defines the navigation capabilities that can be injected into SwiftUI Views
/// and ViewModels via an `@EnvironmentObject`.
///
/// This protocol decouples Views and ViewModels from concrete navigation implementations,
/// allowing them to push, pop, or replace navigation destinations without depending
/// on the underlying navigation system (e.g., `NavigationStack`).
protocol Router: ObservableObject {
    /// The currently active modal navigation destination (e.g., for sheets or full-screen covers).
    ///
    /// Setting this property to a non-nil value should trigger a modal presentation.
    /// Setting it back to `nil` should dismiss the modal.
    var currentDestination: NavigationDestination? { get set }

    /// The navigation stack state used in a `NavigationStack`.
    ///
    /// This is updated as destinations are pushed or popped, and can be reset to return to the root.
    var navigationPath: NavigationPath { get set }

    /// Pushes a new destination onto the navigation stack.
    /// - Parameter destination: The `NavigationDestination` to push onto the stack.
    func push(destination: NavigationDestination)

    /// Pops the top view from the navigation stack.
    func pop()

    /// Pops all views from the navigation stack back to the root.
    func popToRoot()

    /// Replaces the entire navigation stack with a new root destination.
    /// - Parameter destination: The new root `NavigationDestination` to set.
    ///
    /// This clears any previous navigation history and starts a new stack with the given destination.
    func setRoot(destination: NavigationDestination)
}
