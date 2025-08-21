//
//  IncidentFilterView.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import SwiftUI

// MARK: - IncidentFilterView

/// A view that provides UI controls to filter incidents by **status** and **date**.
///
struct IncidentFilterView: View {
    /// The currently selected status filter. `nil` means no filter is applied.
    @Binding var status: IncidentsStatus?

    /// The currently selected date filter. `nil` means no filter is applied.
    @Binding var date: Date?

    /// Controls whether the status picker sheet is visible.
    @State private var showingStatusSheet = false

    /// Controls whether the date picker sheet is visible.
    @State private var showingDataPicker = false

    var body: some View {
        HStack(spacing: 0) {
            // MARK: - Status Button

            /// Button to select the incident status.
            /// Shows an icon, label, and the currently selected status name (if any).
            Button {
                showingStatusSheet = true
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .font(.callout)

                    Text("Status" + (status != nil ? ":" : ""))
                        .font(.callout)

                    Text(status?.name ?? "")
                        .font(.footnote)
                        .foregroundStyle(.orange)
                        .renderedIf(status?.name != nil)
                }
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
            }

            DividerView()

            // MARK: - Date Button

            /// Button to select the incident date.
            /// Shows an icon, label, and the currently selected formatted date (if any).
            Button {
                showingDataPicker = true
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "calendar.circle")
                        .font(.callout)

                    Text("Date" + (date != nil ? ":" : ""))
                        .font(.callout)

                    Text(formattedDate ?? "")
                        .font(.footnote)
                        .foregroundStyle(.orange)
                        .renderedIf(formattedDate != nil)
                }
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 8)
        .frame(height: 50)
        .background(.regularMaterial)
        .cornerRadius(8)
        .sheet(isPresented: $showingStatusSheet) {
            // Presents the status selection sheet
            StatusFilterView(selectedStatus: $status)
                .presentationDetents([.height(230)])
        }
        .sheet(isPresented: $showingDataPicker) {
            // Presents the date selection sheet
            DatePickerView(date: $date, displayedComponents: [.date])
                .presentationDetents([.fraction(0.65), .large])
        }
    }

    // MARK: - Divider Helper

    /// A vertical divider between the status and date buttons.
    @ViewBuilder
    private func DividerView() -> some View {
        Rectangle()
            .fill(Color.white.opacity(0.5))
            .frame(width: 1)
    }
}

extension IncidentFilterView {
    /// Returns the formatted date string for display in the button.
    /// - Returns: A `String` formatted using `.medium` style, or `nil` if no date is selected.
    private var formattedDate: String? {
        date?.toString(formatter: .medium)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 16) {
        IncidentFilterView(status: .constant(nil), date: .constant(nil))
        IncidentFilterView(status: .constant(.completed), date: .constant(.now))
    }
    .padding()
}
