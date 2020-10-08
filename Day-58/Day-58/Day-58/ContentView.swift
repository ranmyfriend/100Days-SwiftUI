//
//  ContentView.swift
//  Day-58
//
//  Created by Ranjit on 08/10/20.
//

import SwiftUI
import CoreData

//Day-58
//1)Filtering @FetchRequest using NSPredicate
//2)Dynamically filtering @FetchRequest with SwiftUI
//3)One-to-many relationships with Core Data, SwiftUI, and @FetchRequest
struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "Star Trek"), animation: nil) var ships: FetchedResults<Ship>
    
    @State private var nameStartsFilter = "D"

    var body: some View {
        NavigationView {
            VStack {
                
                //This one we are applying the predicate on dynamic, and based on the results you can the filtered list.
                //NON-GENERIC CODE
//                FilteredList(filter: nameStartsFilter)
                //GENERIC CODE
                FilteredList(filterKey: "name", filterValue: nameStartsFilter) {
                    (ship: Ship) in
                    Text(ship.name ?? "Unknown name")
                    Text(ship.universe ?? "Unknown universe")
                }
                
                Button("Show D") {
                    self.nameStartsFilter = "D"
                }
                Button("Show E") {
                    self.nameStartsFilter = "E"
                }
                //This one we are simply applying the predicate on the list
//                List(ships, id:\.self) { ship in
//                    VStack {
//                        Text(ship.name ?? "Unknown name")
//                        Text(ship.universe ?? "Unknown universe")
//                    }
//                }
            }
            
            
            .navigationBarItems(leading: EditButton(), trailing: Button(action: addExamples) {
                Label("Add Examples", systemImage: "plus")
            })
        }
    }

    private func addExamples() {
        withAnimation {
            let ship1 = Ship(context: viewContext)
            ship1.name = "Enterprise"
            ship1.universe = "Star wars"
            
            let ship2 = Ship(context: viewContext)
            ship2.name = "Defiant"
            ship2.universe = "Star Trek"
            
            let ship3 = Ship(context: viewContext)
            ship3.name = "Millianium Falcon"
            ship3.universe = "Star Trek"

            let ship4 = Ship(context: viewContext)
            ship4.name = "Executor"
            ship4.universe = "Star Trek"
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    /*
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }*/
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
