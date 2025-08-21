//
//  StatusFilterView.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import SwiftUI

// MARK: - StatusFilterView

/// A view that presents a list of incident statuses for selection.

struct StatusFilterView: View {
    /// The currently selected status filter. `nil` means no filter is applied.
    @Binding var selectedStatus: IncidentsStatus?

    /// Environment property to dismiss the view when a selection is made.
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            ForEach(IncidentsStatus.allCases, id: \.rawValue) { status in

                // MARK: - Status Button

                /// Button to select or deselect a status.
                Button(action: {
                    if selectedStatus == status {
                        // Clear selection if tapped again
                        selectedStatus = nil
                    } else {
                        selectedStatus = status
                    }
                    // Dismiss the sheet after selection
                    dismiss()
                }) {
                    HStack {
                        Text(status.name)
                            .foregroundColor(.primary)

                        Spacer()

                        // Show checkmark for the selected status
                        if selectedStatus == status {
                            Image(systemName: "checkmark")
                                .font(.body)
                                .foregroundStyle(Color.white)
                        }
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 4)
                }

                // Add divider except after the last status
                if status != IncidentsStatus.allCases.last {
                    Divider()
                }

                Spacer()
            }
        }
        .cornerRadius(8)
        .padding(.all, 16)
    }
}

// MARK: - Preview

#Preview {
    StatusFilterView(selectedStatus: .constant(.completed))
}
