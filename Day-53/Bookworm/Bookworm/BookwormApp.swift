//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Ranjit on 01/10/20.
//

import SwiftUI

@main
struct BookwormApp: App {
//    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            TestBinding()
        }
    }

//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//        }
//    }
}
