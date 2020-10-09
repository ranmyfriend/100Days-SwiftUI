//
//  ContentView.swift
//  Day-59
//
//  Created by Ranjit on 09/10/20.
//

import SwiftUI
import CoreData

//Day-59
//Challenge Project

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    //NSPredicate(format: "name == %@", "Rave")
    //"name BEGINSWITH %@", "R")
    //"name CONTAINS %@", "R")
    @FetchRequest(entity: Student.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Student.name, ascending: false)], predicate: NSPredicate(format: "name CONTAINS %@", "J"), animation: .default) var students: FetchedResults<Student>

    var body: some View {
        NavigationView {
            List {
                ForEach(students, id: \.self) { student in
                    Text(student.name ?? "Unknown name")

                }
                .onDelete(perform: deleteItems)
            }
            .navigationBarItems(leading:  EditButton(), trailing: Button(action: addItem) {
                Label("Add Student", systemImage: "plus")
            })
            .navigationBarTitle("Challenge Project")
        }
    }

    var names = ["Apple","Rave","Tiwatia","Jobs","Gamer"]
    
    private func addItem() {
        withAnimation {
            let newItem = Student(context: viewContext)
            newItem.name = names.randomElement()

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

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { students[$0] }.forEach(viewContext.delete)

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
}

//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
