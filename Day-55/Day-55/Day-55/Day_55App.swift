//
//  Day_55App.swift
//  Day-55
//
//  Created by Ranjit on 05/10/20.
//

import SwiftUI

@main
struct Day_55App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
