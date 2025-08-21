//
//  View+Conditionals.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import SwiftUI

extension View {
    /// Renders a view if the provided  `condition` is met.
    /// If the `condition` is not met, an `nil`  will be used in place of the receiver view.
    ///
    func renderedIf(_ condition: Bool) -> Self? {
        guard condition else {
            return nil
        }
        return self
    }

    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View` if the condition is `true`.
    ///   - else: An optional transform to apply if the condition is `false`.
    /// - Returns: Either the original `View`, or a modified `View` depending on the condition.
    @ViewBuilder
    func `if`<TrueContent: View, FalseContent: View>(
        _ condition: @autoclosure () -> Bool,
        transform: (Self) -> TrueContent,
        else elseTransform: (Self) -> FalseContent
    ) -> some View {
        if condition() {
            transform(self)
        } else {
            elseTransform(self)
        }
    }

    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View` if the condition is `true`.
    /// - Returns: Either the original `View` or the modified `View`.
    @ViewBuilder
    func `if`<Content: View>(
        _ condition: @autoclosure () -> Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
}
