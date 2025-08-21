//
//  MapPickerView.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import CoreLocation
import MapKit
import SwiftUI

struct MapPickerView: View {
    @Binding var selectedLocation: LocationModel?
    @State private var currentLocation: LocationModel?
    let placeholder: String

    private let geocoder = CLGeocoder()
    @State private var isSheetPresented = false
    @State private var cameraPosition: MapCameraPosition
    @State private var currentAddress: String = ""
    @State private var currentCenter: CLLocationCoordinate2D
    @State private var debounceTask: Task<Void, Never>?
    @State private var lastUpdateTime = Date()
    @State private var isShowingProgress: Bool = false

    init(selectedLocation: Binding<LocationModel?>, placeholder: String) {
        _selectedLocation = selectedLocation
        self.placeholder = placeholder

        if let coordinate = selectedLocation.wrappedValue?.coordinate {
            let region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            _cameraPosition = State(initialValue: .region(region))
            _currentAddress = State(initialValue: selectedLocation.wrappedValue?.title ?? "")
            _currentCenter = State(initialValue: coordinate)
        } else {
            let defaultCoordinate = CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357) // Cairo
            let region = MKCoordinateRegion(
                center: defaultCoordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            _cameraPosition = State(initialValue: .region(region))
            _currentAddress = State(initialValue: "")
            _currentCenter = State(initialValue: defaultCoordinate)
        }
    }

    var body: some View {
        Button {
            isSheetPresented.toggle()
        } label: {
            Text(selectedLocation?.title ?? placeholder)
                .foregroundStyle(selectedLocation?.title == nil ? .gray : .white)
                .font(.body)
                .padding(.horizontal, 8)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .sheet(isPresented: $isSheetPresented) {
            VStack(spacing: 16) {
                if isShowingProgress {
                    ProgressView("Loading...")
                } else {
                    // Show the current address above the map
                    Text(currentAddress.isEmpty ? "Center your location on the map" : currentAddress)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding()
                }

                Map(position: $cameraPosition)
                    .edgesIgnoringSafeArea(.top)
                    .frame(maxHeight: .infinity)
                    .overlay {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title)
                            .tint(.red)
                    }
                    .onMapCameraChange(frequency: .continuous) { context in
                        // Update center and timestamp on every change
                        currentCenter = context.region.center
                        lastUpdateTime = Date()

                        // Start debounced geocoding
                        startDelayedGeocode()
                    }

                Button {
                    // Use the tracked center coordinate
                    selectedLocation = currentLocation
                    isSheetPresented = false
                } label: {
                    Text("Confirm")
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.all, 16)
                        .disabled(isShowingProgress)
                }
            }
            .padding(.top, 16)
            .presentationDetents([.medium, .large])
        }
    }

    private func startDelayedGeocode() {
        // Cancel any existing task
        debounceTask?.cancel()

        // Capture current values
        let coordinateToGeocode = currentCenter
        let updateTime = lastUpdateTime

        debounceTask = Task {
            do {
                // Wait for 1 second
                try await Task.sleep(nanoseconds: 1_000_000_000)

                // Check if task was cancelled or if there was a more recent update
                guard !Task.isCancelled && updateTime == lastUpdateTime else {
                    return
                }

                await performGeocode(coordinateToGeocode, updatePreview: true)
            } catch {
                // Task was cancelled
                return
            }
        }
    }

    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D, updatePreview: Bool) {
        if updatePreview {
            // For preview, use the delayed geocoding
            startDelayedGeocode()
        } else {
            // Cancel any pending preview tasks when user confirms
            debounceTask?.cancel()
            debounceTask = nil

            // Immediate geocoding for final selection
            Task {
                await performGeocode(coordinate, updatePreview: false)
            }
        }
    }

    @MainActor
    private func performGeocode(_ coordinate: CLLocationCoordinate2D, updatePreview: Bool) async {
        defer { isShowingProgress = false }
        isShowingProgress = true
        // Additional check to ensure we're not processing an outdated coordinate
        guard !Task.isCancelled else { return }

        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)

            // Check again after async operation in case task was cancelled
            guard !Task.isCancelled, let placemark = placemarks.first else { return }

            let title = [
                placemark.name,
                placemark.locality,
                placemark.administrativeArea,
                placemark.country
            ]
            .compactMap { $0 }
            .joined(separator: ", ")

            // Final check before updating UI
            guard !Task.isCancelled else { return }

            currentAddress = title
            currentLocation = LocationModel(title: title, coordinate: coordinate)

        } catch {
            // Handle geocoding errors gracefully, but only if task wasn't cancelled
            guard !Task.isCancelled else { return }

            if updatePreview {
                currentAddress = "Unable to determine address"
                currentLocation = nil
            }
        }
    }
}

// MARK: - Preview

#Preview {
    MapPickerView(
        selectedLocation: .constant(LocationModel(
            title: "Cairo, Egypt",
            coordinate: CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357)
        )),
        placeholder: "Select a location"
    )
    .padding()
}
