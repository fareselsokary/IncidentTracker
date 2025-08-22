//
//  View+dismissKeyboardOnTap.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import SwiftUI

// MARK: - View Modifier
struct DismissKeyboardOnTap: ViewModifier {
    func body(content: Content) -> some View {
        content
            .gesture(
                TapGesture()
                    .onEnded { _ in
                        UIApplication.shared.sendAction(
                            #selector(UIResponder.resignFirstResponder),
                            to: nil, from: nil, for: nil
                        )
                    }
            )
    }
}

// MARK: - View Extension
extension View {
    func dismissKeyboardOnTap() -> some View {
        self.modifier(DismissKeyboardOnTap())
    }
}

