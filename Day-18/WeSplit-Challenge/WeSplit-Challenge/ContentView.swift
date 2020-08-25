//
//  ContentView.swift
//  WeSplit-Challenge
//
//  Created by Ranjit on 19/08/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

//This Project is Challenge for some changes from WeSplit Project

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = "2"
    @State private var tipPercentage = 2
    var tipPercentages = [10, 15, 20, 25, 0]

    var totalPerPerson: Double {
        let peopleCount = Double((Int(numberOfPeople) ?? 0) )
        let amountPerPerson = originalAmountPlusTip / peopleCount
        
        return amountPerPerson
    }
    
    var originalAmountPlusTip: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        //This is the calcualtion for calculating the amount per person
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        return grandTotal
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    TextField("Number of People", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("How much tip you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach (0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0]) %")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                Section {
                        Text("Total amount for the check:$\(originalAmountPlusTip, specifier: "%.2f")")
                            .foregroundColor(tipPercentage == 4 ? .red : .black) //4th Index goes to Zero Tip
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
