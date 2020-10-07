//
//  ContentView.swift
//  Day-57
//
//  Created by Ranjit on 07/10/20.
//

import SwiftUI

//Day-57
//1)Why does \.self work for ForEach?
//2)Creating NSManagedObject subclasses
//3)Conditional saving of NSManagedObjectContext
    /* NOTES:
        when you go with try? self.moc.save() directly without knowing the moc has changes or not? so always check whether moc has having any changes then go for save.
        
            if self.moc.hasChanges { try? self.moc.save() }
 */
//4)Ensuring Core Data objects are unique using constraints

struct Person: Hashable { //On confirming the Hashable protocol in Person Model. the properties which are belongs to this model creates each one has different hash.
    //But what about NSManagedObject, should we need to confirm the Hashable protocol there. no need. because every coredata objects have their one Unique UUID.
    let name: String
}

struct ContentView_Topic1: View {

    var people = [Person(name: "Alpha"),
                  Person(name: "Gamma")]
    var body: some View {
        /*List {
            //Here \.self will do the verification purpose and evaluate the hashing
            ForEach([2,4,6,8], id:\.self) {
                Text("\($0) is Even")
            }
        }*/
        
        List(people, id: \.self) {
            Text($0.name)
        }
    }
}

/* NOTES:
 When you create an Entity on dataModel. xcode creates a data class for us. But if you are using the Xcode created Model. then all the attributes are Nil ie.Optional. So whenever you want to assign or use, you must unwrapped explicitly. This is completely irritated. This is happens default on codegen => when selected `class defenition`. But if you want change to `Manual/none`. Now the food is ours, we can control to create our own entity to access how ever we want with custom NSManagedObject subclass
 */
struct ContentView_Topic2: View {
    @Environment(\.managedObjectContext) private var moc

    var body: some View {
        Text("CORE-DATA")
    }
}

struct ContentView_Topic4: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: Wizard.entity(), sortDescriptors:  []) var wizards: FetchedResults<Wizard>

    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown name")
            }
            
            Button("Add") {
                let wizard = Wizard(context: self.moc)
                wizard.name = "Harry"
            }
            
            //When you click the save button you can see the error log on debugger window. because of name we kept it has unique constraint. thats why we are not able to save it.
            //But however we are ready send duplicates but coredata will accept only one value; for this case we have to enable some set of merge policy
            //        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

            Button("Save") {
                do {
                    try moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_Topic2().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
