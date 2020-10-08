//
//  FilteredList.swift
//  Day-58
//
//  Created by Ranjit on 08/10/20.
//

import SwiftUI
import CoreData

//NOTE: commented out code are hardcoded kinda filtered list. so here the NSManagedObject and what the fetchrequest is going give us is clearled implies to one particular data and the Model. So we have applied generics to work for any NSManagedObject and once we got fetch results, on top of this we can custom the UI on caller side.

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var ships: FetchedResults<T> {
        fetchRequest.wrappedValue
    }
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest.wrappedValue, id:\.self) { ship in
//            VStack {
//                Text(ship.name ?? "unknown name")
//                Text(ship.universe ?? "unknown universe")
//            }
            self.content(ship)
        }
    }
    
//    init(filter: String) {
//        fetchRequest = FetchRequest<Ship>(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name BEGINSWITH %@", filter), animation: nil)
//    }
    
    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue), animation: nil)
        self.content = content
    }
}

//struct FilteredList_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredList(filter: "A")
//    }
//}
