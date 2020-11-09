//
//  TvTrackerApp.swift
//  TvTracker
//
//  Created by cedric blaser on 09.11.20.
//

import SwiftUI

@main
struct TvTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
