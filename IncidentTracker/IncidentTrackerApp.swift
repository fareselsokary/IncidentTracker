//
//  IncidentTrackerApp.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import SwiftUI

// MARK: - IncidentTrackerApp

@main
struct IncidentTrackerApp: App {
    @StateObject private var appRouter: AppRouter = AppRouter()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .environmentObject(appRouter)
        }
    }
}
