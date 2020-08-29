//
//  ContentView.swift
//  Day-28-Challenge
//
//  Created by Ranjit on 29/08/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

//Project 4 Part 3: Challenge
struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1 //Here i have removed calculate button and whenever the coffeeAmount value changes automatically the alert will shown

    @State private var alertTitle = ""
    @State private var alertMsg = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: //Previously we went with VStack but now i have modified with Sections and header
                    Text("When do you want to wak up?")
                        .font(.headline)) {
                            DatePicker(
                                "please enter a time",
                                selection: $wakeUp,
                                displayedComponents: .hourAndMinute
                            )
                                .labelsHidden()
                                .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header:
                    Text("Desired amount of sleep")
                        .font(.headline)) {
                            
                            Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                                Text("\(sleepAmount, specifier: "%g") hours")
                            }
                }
                
                Section(header:
                    Text("Daily coffee intake")
                        .font(.headline)) {
                            
                            Picker("How many cups?", selection: $coffeeAmount.onUpdate {
                                self.calculateBedtime()
                            }) {
                                ForEach(0..<21) { num in
                                    if num + 1 == 1 {
                                        Text("\(num+1) cup coffee")
                                    } else {
                                        Text("\(num+1) cups coffee")
                                    }
                                }
                            }
                }
            }
            .navigationBarTitle("BetterRest")
            .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMsg), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    //by default the datepicker will show the current time. but usually user will pick from 7am or something else in the AM style. thats why we are having this computed property
    //Here Why static is required: The reason is that we’re accessing one property from inside another – Swift doesn’t know which order the properties will be created in, so this isn’t allowed.
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedtime() {
        let model = SleepCalculator()
       let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60

        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            alertMsg = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is..."
        } catch {
            alertTitle = "Error"
            alertMsg = "There was a problem in calculating your bedtime"
        }
        
        showingAlert = true
    }
}

extension Binding {
    
    /// When the `Binding`'s `wrappedValue` changes, the given closure is executed.
    /// - Parameter closure: Chunk of code to execute whenever the value changes.
    /// - Returns: New `Binding`.
    func onUpdate(_ closure: @escaping () -> Void) -> Binding<Value> {
        Binding(get: {
            self.wrappedValue
        }, set: { newValue in
            self.wrappedValue = newValue
            closure()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
