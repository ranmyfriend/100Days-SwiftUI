//
//  Day_56App.swift
//  Day-56
//
//  Created by Ranjit on 06/10/20.
//

import SwiftUI

@main
struct Day_56App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
