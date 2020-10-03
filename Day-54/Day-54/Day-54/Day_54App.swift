//
//  Day_54App.swift
//  Day-54
//
//  Created by Ranjit on 03/10/20.
//

import SwiftUI

@main
struct Day_54App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
