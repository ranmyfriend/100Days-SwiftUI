//
//  Day_59App.swift
//  Day-59
//
//  Created by Ranjit on 09/10/20.
//

import SwiftUI

@main
struct Day_59App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
