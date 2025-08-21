//
//  AsyncImageView.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import Kingfisher
import SwiftUI

// MARK: - AsyncImageView

/// A view that asynchronously loads and displays an image with an optional placeholder.
/// Uses `Kingfisher` under the hood for fetching and caching images.
struct AsyncImageView<Placeholder: View>: View {
    private let imageURL: URL?
    private let placeholder: () -> Placeholder

    // MARK: - Default Placeholder

    // MARK: - Main Initializer

    /// Creates an image view for a URL, with an optional placeholder.
    ///
    /// - Parameters:
    ///   - imageURL: The remote image URL.
    ///   - placeholder: A view builder for the placeholder displayed while loading. Defaults to a light gray rectangle.
    init(
        _ imageURL: URL?,
        @ViewBuilder placeholder: @escaping () -> Placeholder = { DefaultImagePlaceholder() }
    ) {
        self.imageURL = imageURL
        self.placeholder = placeholder
    }

    /// Creates an image view for a string URL, with an optional placeholder.
    ///
    /// - Parameters:
    ///   - imageURL: The remote image URL string.
    ///   - placeholder: A view builder for the placeholder displayed while loading. Defaults to a light gray rectangle.
    init(
        _ imageURL: String?,
        @ViewBuilder placeholder: @escaping () -> Placeholder = { DefaultImagePlaceholder() }
    ) {
        self.imageURL = URL(string: imageURL ?? "")
        self.placeholder = placeholder
    }

    // MARK: - Body

    var body: some View {
        KFImage(imageURL)
            .resizable()
            .placeholder { placeholder() }
            .fade(duration: 0.2)
            .cancelOnDisappear(true)
    }
}

// MARK: - DefaultImagePlaceholder

struct DefaultImagePlaceholder: View {
    var body: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .overlay(Image(systemName: "photo")
                .foregroundColor(.gray))
    }
}
