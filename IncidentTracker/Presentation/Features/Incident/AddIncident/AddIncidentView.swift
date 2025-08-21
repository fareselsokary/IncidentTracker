//
//  AddIncidentView.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import SwiftUI

// MARK: - AddIncidentView

/// A form-like view that allows the user to create and submit a new incident.
///
/// Features:
/// - Image picker for attaching a photo.
/// - Pickers for selecting status, incident type, subtype, and location.
/// - Text editor for entering a description.
/// - Submit button that validates input and sends data via the `AddIncidentViewModel`.
struct AddIncidentView: View {
    /// The view model that manages incident data and submission.
    @StateObject var viewModel: AddIncidentViewModel

    /// App-wide router used for navigation control.
    @EnvironmentObject var appRouter: AppRouter

    /// The currently selected image (if any) from the image picker.
    @State private var selectedImage: UIImage?

    /// Controls whether the image picker sheet is shown.
    @State private var showImagePicker = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // MARK: - Image Section

                Group {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .overlay(Text("Select an Image"))
                    }
                }
                .frame(height: 160)
                .onTapGesture {
                    showImagePicker = true
                }
                .clipShape(RoundedRectangle(cornerRadius: 15))

                // MARK: - Status Picker

                sectionView("Status") {
                    FormPickerView(
                        selectedOption: $viewModel.selectedStatus,
                        options: IncidentsStatus.allCases,
                        placeholder: "Status"
                    )
                }

                // MARK: - Type Picker

                sectionView("Incident Type") {
                    FormPickerView(
                        selectedOption: $viewModel.selectedType,
                        options: viewModel.incidentTypes,
                        placeholder: "Incident Type"
                    )
                }

                // MARK: - Subtype Picker

                sectionView("Incident Subtype") {
                    FormPickerView(
                        selectedOption: $viewModel.selectedSubType,
                        options: viewModel.incidentSubtypes,
                        placeholder: "Incident Subtype"
                    )
                }
                .renderedIf(!viewModel.incidentSubtypes.isEmpty)

                // MARK: - Location Picker

                sectionView("Incident Location") {
                    MapPickerView(
                        selectedLocation: $viewModel.selectedLocation,
                        placeholder: "Location"
                    )
                }

                // MARK: - Description

                sectionView("Incident description") {
                    TextEditor(text: $viewModel.description)
                        .scrollContentBackground(.hidden)
                        .padding(8)
                        .frame(height: 100)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(8)
                }

                // MARK: - Submit Button

                Button {
                    viewModel.submitData()
                } label: {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .opacity(viewModel.canSubmit ? 1 : 0.5)
                }
                .disabled(!viewModel.canSubmit)
            }
        }
        // Apply vertical and horizontal padding for scroll content.
        .contentMargins(.vertical, 8, for: .scrollContent)
        .contentMargins(.horizontal, 16, for: .scrollContent)
        // Show toast messages based on the view model’s message state.
        .toast($viewModel.message)
        // Show a loading indicator when `isLoading` is true.
        .loading(isLoading: viewModel.isLoading)
        // Configure navigation title.
        .navigationTitle("Add Incident")
        .navigationBarTitleDisplayMode(.inline)
        // Hide keyboard on background tap.
        .dismissKeyboardOnTap()
        // Show the image picker sheet.
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }

        // Handle when a new image is selected.
        .onChange(of: selectedImage) { _, newValue in
            if let image = newValue {
                viewModel.addImage(image.jpegData(compressionQuality: 0.5))
            }
        }

        // Handle navigation after a successful submission.
        .onChange(of: viewModel.isRequestSubmitted) { _, newValue in
            if newValue {
                appRouter.pop()
            }
        }
    }
}

// MARK: - Section Helper

extension AddIncidentView {
    /// A reusable helper view for rendering form sections with a title.
    ///
    /// - Parameters:
    ///   - title: The title displayed above the section.
    ///   - content: The content of the section (pickers, text editors, etc.).
    @ViewBuilder
    func sectionView<Content: View>(
        _ title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)

            content()
        }
    }
}

// MARK: - Preview

#Preview {
    let useCase = AddIncidentUseCase(incidentRepository: IncidentRepository())
    let viewModel = AddIncidentViewModel(addIncidentUseCase: useCase)
    AddIncidentView(viewModel: viewModel)
        .preferredColorScheme(.dark)
}
