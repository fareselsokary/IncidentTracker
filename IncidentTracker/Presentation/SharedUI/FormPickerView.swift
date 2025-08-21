//
//  FormPickerView.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import SwiftUI

// MARK: - FormPickerView

/// A reusable SwiftUI form component that allows users to pick a single option
/// from a list presented in a bottom sheet.
///
/// `FormPickerView` is generic and works with any type that conforms to
/// both `Identifiable` and `Titled`. It shows the currently selected option
/// (or a placeholder if none is selected), and presents a scrollable sheet
/// for the user to choose an option.
///
/// Example:
/// ```swift
/// struct Category: Identifiable, Titled {
///     let id: UUID = UUID()
///     let title: String
/// }
///
/// @State private var selectedCategory: Category?
/// let categories = [Category(title: "Work"), Category(title: "Personal")]
///
/// FormPickerView(
///     selectedOption: $selectedCategory,
///     options: categories,
///     placeholder: "Select Category"
/// )
/// ```
struct FormPickerView<T: Identifiable & Titled>: View {
    // MARK: - Inputs

    /// The currently selected option, bound to an external state.
    @Binding var selectedOption: T?

    /// The list of all available options.
    let options: [T]

    /// The placeholder text shown when no option is selected.
    let placeholder: String

    // MARK: - Local State

    /// Controls whether the sheet with options is presented.
    @State private var isSheetPresented = false

    // MARK: - Body

    var body: some View {
        Button {
            isSheetPresented.toggle()
        } label: {
            Text(selectedOption?.title ?? placeholder)
                .foregroundStyle(textIsEmpty ? .gray : .white)
                .font(.body)
                .if(!textIsEmpty) { view in
                    view.bold()
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .background(Color.white.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .sheet(isPresented: $isSheetPresented) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(options) { option in
                        Button {
                            selectedOption = option
                            isSheetPresented = false
                        } label: {
                            HStack {
                                Text(option.title)
                                    .foregroundStyle(Color.white)
                                    .padding()
                                Spacer()
                            }
                        }
                        Divider()
                    }
                }
            }
            .padding(.vertical)
            .presentationDetents([.fraction(0.4)])
        }
    }
}

// MARK: - Helpers

extension FormPickerView {
    /// Returns `true` if no option is selected or the selected option’s title is empty.
    var textIsEmpty: Bool {
        selectedOption?.title.isEmpty ?? true
    }
}
