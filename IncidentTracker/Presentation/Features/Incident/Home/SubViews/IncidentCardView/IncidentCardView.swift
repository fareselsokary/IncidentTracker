//
//  IncidentCardView.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import SwiftUI

// MARK: - IncidentCardView

/// A card view that displays information about a single incident.
///
struct IncidentCardView: View {
    /// The view model providing the incident data.
    @StateObject var viewModel: IncidentCardViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // MARK: - Incident Image

            /// Displays the first media image of the incident.
            /// The status badge overlays the top-right corner of the image.
            AsyncImageView(viewModel.imageURL)
                .frame(height: 150)
                .overlay(alignment: .topTrailing) {
                    Text(viewModel.status)
                        .font(.caption)
                        .bold()
                        .padding(.all, 4)
                        .background {
                            Capsule()
                                .fill(Color.orange)
                        }
                        .padding(.all, 10)
                }

            // MARK: - Incident Dates

            /// Shows created and updated timestamps of the incident.
            VStack(spacing: 6) {
                HStack {
                    Text("Created at:")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text(viewModel.createdAt)
                        .font(.caption)
                        .bold()
                }

                HStack {
                    Text("Updated at:")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text(viewModel.updatedAt)
                        .font(.caption)
                        .bold()
                }
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 12)
        }
        .background(Color.white.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

// MARK: - Preview

#Preview {
    IncidentCardView(viewModel: IncidentCardViewModel(incident: .mock))
        .padding(16)
        .preferredColorScheme(.dark)
}
