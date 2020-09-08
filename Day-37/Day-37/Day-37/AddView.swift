//
//  AddView.swift
//  Day-37
//
//  Created by Ranjit on 08/09/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "personal"
    @State private var amount = ""
    static let types = ["personal","business"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id:\.self) {
                        Text($0)
                    }
                }
            
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            
            }
            .navigationBarTitle("Add new expenses")
            .navigationBarItems(trailing: Button(action: {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }, label: {
                Text("Save")
            }))
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
