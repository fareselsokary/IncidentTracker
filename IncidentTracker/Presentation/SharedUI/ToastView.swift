//
//  ToastView.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import SwiftUI

// MARK: - ToastView

/// A reusable SwiftUI view that displays a toast message with an icon and background color
/// depending on the toast type (`success` or `error`).
///
/// Features:
/// - Smooth transition animation from the top.
/// - Automatically adjusts background color and SF Symbol icon.
/// - Styled with rounded corners, padding, and shadow.
///
/// Usage:
/// ```swift
/// @State private var toast: ToastMessage?
///
/// VStack {
///     Button("Show Success") {
///         toast = .success("Operation completed successfully!")
///     }
///
///     Button("Show Error") {
///         toast = .error("Something went wrong")
///     }
/// }
/// .toast($toast, maxVisible: 2, duration: 2)
/// ```
struct ToastView: View {
    /// The toast message to display (success or error).
    let toast: ToastMessage

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)

            Text(toast.message)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .bold()

            Spacer()
        }
        .padding(16)
        .background(backgroundColor)
        .cornerRadius(10)
        .shadow(radius: 10)
        .transition(.move(edge: .top).combined(with: .blurReplace))
    }

    // MARK: - Helpers

    /// Background color depends on toast type.
    private var backgroundColor: Color {
        switch toast {
        case .success: return .green
        case .error: return .red
        }
    }

    /// SF Symbol icon depends on toast type.
    private var icon: String {
        switch toast {
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.octagon.fill"
        }
    }
}

// MARK: - ToastMessage

/// Represents a toast notification type (success or error) with an associated message.
/// Conforms to `Identifiable` for SwiftUI binding support.
///
/// Each toast has a unique `UUID` to allow distinct identification in queues.
enum ToastMessage: Identifiable, Hashable {
    case success(String, UUID = UUID())
    case error(String, UUID = UUID())

    /// The message text associated with the toast.
    var message: String {
        switch self {
        case let .success(message, _): return message
        case let .error(message, _): return message
        }
    }

    /// Unique identifier for SwiftUI’s `Identifiable` protocol.
    var id: UUID {
        switch self {
        case let .success(_, id): return id
        case let .error(_, id): return id
        }
    }

    /// Ensures uniqueness by hashing only the message string.
    func hash(into hasher: inout Hasher) {
        hasher.combine(message)
    }
}

// MARK: - Preview

#Preview("Toast Queue Demo") {
    struct InlineDemo: View {
        @State private var toast: ToastMessage?

        var body: some View {
            VStack(spacing: 20) {
                Button("Show Success") {
                    toast = .success("✅ Success \(Int.random(in: 1 ... 100))")
                }

                Button("Show Error") {
                    toast = .error("❌ Error \(Int.random(in: 1 ... 100))")
                }
            }
            .padding()
            .toast($toast, maxVisible: 2, duration: 2)
        }
    }

    return InlineDemo()
}
