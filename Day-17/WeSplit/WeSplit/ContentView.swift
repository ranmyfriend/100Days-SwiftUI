//
//  ContentView.swift
//  WeSplit
//
//  Created by Ranjit on 18/08/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

/* Today topics are:
 1)Reading text from the user with TextField
 2)Creating pickers in a form
 3)Adding a segmented control for tip percentages
 4)Calculating the total per person
 */

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = "" //Why i have used checkAmount as String, because this is the one we are going to binding into TextField. So TextField only accepts String
    //And anyone of the State propety which is followed by read or read&Write the entire body property will be redrawn automatically. This is taken care by SwiftUI
    @State private var numberOfPeople = 2 //This is going to be used in Picker
    @State private var tipPercentage = 2
    var tipPercentages = [10, 15, 20, 25, 0]
    //This computed property calcualtes the total per person
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        //This is the calcualtion for calculating the amount per person
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    //You will be spotting the closure indicator on the right side, this denotes something is going to be tapable here. This is automatically taken care by Swift UI. Generally it takes care of moving to another screen
                    //And if you dont have NavigationView on top of the Form, then it wont perform anything
                    //And also once you have picked your 'No.of.people' then automatically it will comes to the main screen, and you can see the selected item on the picker value. This is completed works with help of TwoWayBinding.
                    Picker("No of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0)")
                        }
                    }
                }
                //This header is acting like TableView header and it contains one TextView.
                Section(header: Text("How much tip you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach (0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0]) %")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Text("$\(totalPerPerson, specifier: "%.2f")") //Here %.2f will define the precision how many digits you want afer the decimal
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
