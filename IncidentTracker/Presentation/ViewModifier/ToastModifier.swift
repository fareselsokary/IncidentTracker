//
//  ToastModifier.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import SwiftUI

// MARK: - ToastQueueModifier

struct ToastQueueModifier: ViewModifier {
    @Binding var toast: ToastMessage? // user binds ONE toast
    let maxVisible: Int
    let duration: TimeInterval

    @State private var queue: [ToastMessage] = []
    @State private var visible: [ToastMessage] = []

    func body(content: Content) -> some View {
        ZStack {
            content

            VStack(spacing: 8) {
                ForEach(visible) { toast in
                    ToastView(toast: toast)
                        .onAppear {
                            let toastID = toast.id
                            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                withAnimation {
                                    visible.removeAll { $0.id == toastID }
                                    showNext()
                                }
                            }
                        }
                }
                Spacer()
            }
            .padding()
            .animation(.spring(), value: visible)
            .onChange(of: toast) { oldValue, newValue in
                if let msg = newValue {
                    queue.append(msg)
                    toast = nil // clear external binding immediately
                    showNext()
                }
            }
        }
    }

    private func showNext() {
        guard !queue.isEmpty else { return }
        guard visible.count < maxVisible else { return }

        let next = queue.removeFirst()
        withAnimation {
            visible.append(next)
        }
    }
}

extension View {
    func toast(
        _ toast: Binding<ToastMessage?>,
        maxVisible: Int = 2,
        duration: TimeInterval = 2
    ) -> some View {
        modifier(ToastQueueModifier(
            toast: toast,
            maxVisible: maxVisible,
            duration: duration
        ))
    }
}
