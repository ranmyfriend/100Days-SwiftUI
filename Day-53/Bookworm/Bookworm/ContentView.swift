//
//  ContentView.swift
//  Bookworm
//
//  Created by Ranjit on 01/10/20.
//

import SwiftUI
import CoreData

//Day-53
//Project 11 part 1
//Here we are going to see CoreData Framework integration and Binding framework
//OLD code so its giving some error. i am just leaving it for now. later on i will pitch it up for the continuation.
/*
struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>

    var body: some View {
        VStack {
            List {
                ForEach(students, id: \.id) { student in
                    Text(student.name ?? "Unknown")
                }
            }
            Button("Add") {
                let firstNames = ["ram", "laxman", "ranjith"]
                let lastNames = ["kumar", "kandh", "kumer"]

                let firstName = firstNames.randomElement()!
                let lastName = lastNames.randomElement()!

                let student = Student(context: self.moc)
                student.id = UUID()
                student.name = firstName + " " + lastName

                try? moc.save()
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
*/
