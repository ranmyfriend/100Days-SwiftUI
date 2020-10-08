//
//  Day_58App.swift
//  Day-58
//
//  Created by Ranjit on 08/10/20.
//

import SwiftUI

@main
struct Day_58App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
