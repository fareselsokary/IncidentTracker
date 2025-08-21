//
//  DatePicker.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import SwiftUI

// MARK: - DatePickerView

/// A reusable date picker view presented inside a sheet.
///
/// It supports optional binding (`Date?`) so users can clear the selection.
/// The picker can be configured to show `.date`, `.hourAndMinute`, or both.
///
/// Example:
/// ```swift
/// @State private var selectedDate: Date? = nil
///
/// Button("Pick Date") {
///     showingPicker = true
/// }
/// .sheet(isPresented: $showingPicker) {
///     DatePickerView(date: $selectedDate, displayedComponents: [.date])
/// }
/// ```
struct DatePickerView: View {
    // MARK: - Inputs

    /// The selected date, bound to an external state. Can be `nil` if cleared.
    @Binding var date: Date?

    /// The type of components to display (e.g., `.date`, `.hourAndMinute`, or both).
    let displayedComponents: DatePickerComponents

    // MARK: - Local State

    /// A temporary date used while interacting with the picker.
    @State private var tempDate: Date = Date()

    /// Access to the current presentation mode for dismissing the sheet.
    @Environment(\.presentationMode) var presentationMode

    // MARK: - Initialization

    init(
        date: Binding<Date?>,
        displayedComponents: DatePickerComponents = [.date]
    ) {
        _date = date
        self.displayedComponents = displayedComponents
    }

    // MARK: - Body

    var body: some View {
        VStack(spacing: 20) {
            // Main DatePicker UI
            DatePicker(
                "Select Date",
                selection: $tempDate,
                displayedComponents: displayedComponents
            )
            .datePickerStyle(.graphical)

            // Action buttons
            HStack(spacing: 24) {
                Group {
                    Button {
                        date = nil
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Clear")
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.red)
                            .background(Color.gray.opacity(0.2))
                    }

                    Button {
                        date = tempDate
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("OK")
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .foregroundColor(.white)
                    }
                }
                .cornerRadius(8)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .onAppear {
            // Sync initial value with external binding
            if let existingDate = date {
                tempDate = existingDate
            }
        }
    }
}

// MARK: - Preview

#Preview {
    struct ContentView: View {
        @State private var selectedDate: Date? = nil
        @State private var showingPicker = false

        var body: some View {
            VStack(spacing: 20) {
                Text("Selected date: \(selectedDate?.formatted(date: .abbreviated, time: .omitted) ?? "None")")

                Button("Pick Date") {
                    showingPicker = true
                }
            }
            .sheet(isPresented: $showingPicker) {
                DatePickerView(date: $selectedDate)
                    .presentationDetents([.fraction(0.65), .large])
            }
            .padding()
        }
    }

    return ContentView()
}
