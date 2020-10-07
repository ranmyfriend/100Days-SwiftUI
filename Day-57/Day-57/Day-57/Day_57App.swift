//
//  Day_57App.swift
//  Day-57
//
//  Created by Ranjit on 07/10/20.
//

import SwiftUI

@main
struct Day_57App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            return ContentView_Topic1()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
