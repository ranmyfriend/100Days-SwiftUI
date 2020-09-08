//
//  ContentView.swift
//  Day-37
//
//  Created by Ranjit on 08/09/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

//Project 7 part 2
/* TOPIC:1 Building a list we can delete from*/

// Here without Identifiable protocol also it will work because we went with id property. but if you confirming to this protocol no need to tell \.id on ForEach loop. because this protocol confirms the id property itself.
struct ExpenseItem: Identifiable, Codable {
    let id = UUID() //This will create new set of UUID everytime. and instead of using name, we can use this
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet { //Why we are using didSet behaviour here, because whenever the the new item get added into the items, we have save this updated list into UserDefaults.
            let encoder = JSONEncoder()
             
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Expense.Items")
            }
        }
    }
    
    init() {
        //Here when we are creating the Expense Model object for loading time, simply cross check whether user already saved any items, the load those into Memory. otherwise simply setting empty array
        if let items = UserDefaults.standard.data(forKey: "Expense.Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct ContentView_TOPIC_1: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAtExpenses = false
    
    var body: some View {
        NavigationView {
            List {
                //, id: \.id
                 //when id: \.name Here the SwiftUI delete the items at last. Because all of the objects are holding the same name text. This is case where we have to introuduce the Identifiable protocol in our custom class
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline) //This headline shows us Title and type will be looking like a SubTitle
                            Text(item.type)
                        }
                        Spacer()
                        Text("$\(item.amount)")
                    }
                }.onDelete(perform: removeItems)
            }
            .navigationBarItems(trailing: Button(action: {
                self.showingAtExpenses = true
            }) {
               Image(systemName: "plus")
            })
        .navigationBarTitle("iExpense")
        .sheet(isPresented: $showingAtExpenses) {
                AddView(expenses: self.expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        self.expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_TOPIC_1()
    }
}
