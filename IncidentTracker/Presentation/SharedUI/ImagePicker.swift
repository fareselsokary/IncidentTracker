//
//  ImagePicker.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import PhotosUI
import SwiftUI

// MARK: - ImagePicker

/// A SwiftUI wrapper around `PHPickerViewController` for selecting a single image
/// from the user’s photo library.
///
/// Features:
/// - Uses `PhotosUI` (modern replacement for `UIImagePickerController`).
/// - Limits selection to a single image.
/// - Automatically dismisses when a selection is made.
/// - Updates a bound `UIImage?` property with the chosen image.
///
/// Usage Example:
/// ```swift
/// @State private var selectedImage: UIImage?
/// @State private var showPicker = false
///
/// Button("Pick Image") {
///     showPicker = true
/// }
/// .sheet(isPresented: $showPicker) {
///     ImagePicker(selectedImage: $selectedImage)
/// }
/// ```
struct ImagePicker: UIViewControllerRepresentable {
    /// A binding to the selected image. This will be updated once the user picks an image.
    @Binding var selectedImage: UIImage?

    /// Controls presentation and dismissal of the picker.
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images        // Restrict to images only
        config.selectionLimit = 1      // Only one image allowed

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // No dynamic updates required
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // MARK: - Coordinator

    /// Handles delegate callbacks from `PHPickerViewController`.
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            // Dismiss picker regardless of result
            parent.presentationMode.wrappedValue.dismiss()

            guard let provider = results.first?.itemProvider,
                  provider.canLoadObject(ofClass: UIImage.self) else { return }

            provider.loadObject(ofClass: UIImage.self) { image, _ in
                DispatchQueue.main.async {
                    self.parent.selectedImage = image as? UIImage
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    struct ContentView: View {
        @State private var selectedImage: UIImage?
        @State private var showPicker = false

        var body: some View {
            VStack {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 200)
                        .overlay(Text("Select an Image"))
                }

                Button("Pick Image") {
                    showPicker = true
                }
            }
            .sheet(isPresented: $showPicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
    }

    return ContentView()
}
