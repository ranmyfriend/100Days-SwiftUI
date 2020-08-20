//
//  ContentView.swift
//  Day-19-Challenge
//
//  Created by Ranjit on 20/08/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

struct Units {
    private init(){}
    static let kCelsius = "Celsius"
    static let kKilometers = "Kilometers"
    static let kHours = "Hours"
    static let kFahrenheit = "Fahrenheit"
    static let kMeters = "Meters"
    static let kSeconds = "Seconds"
}

struct ContentView: View {
    
    @State private var userValue: String = ""
    @State private var inputUnitIndex = 0
    @State private var outputUnitIndex = 0
    
    var inputUnits = [Units.kCelsius,Units.kKilometers,Units.kHours]
    var outputUnits = [Units.kFahrenheit,Units.kMeters,Units.kSeconds]
    
    var conversionResult: Double {
        var result:Double = 0.0
        let ival = Double(userValue) ?? 0
        switch (inputUnits[inputUnitIndex],outputUnits[outputUnitIndex]) {
        case (Units.kCelsius, Units.kFahrenheit):
            //(0°C × 9/5) + 32 = 32°F
            result = (ival * 9/5) + 32
        case (Units.kKilometers, Units.kMeters):
            //multiply the length value by 1000
            result = ival * 1000
        case (Units.kHours, Units.kSeconds):
            //multiply the time value by 3600
            result = ival * 3600
        default:
            print("Select proper conversion Units :(")
        }
        return result
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("0", text: $userValue)
                    .keyboardType(.decimalPad)
                Section(header: Text("Select your Input unit:")) {
                    Picker("Select your Input Unit", selection: $inputUnitIndex) {
                        ForEach (0..<inputUnits.count) {
                            Text("\(self.inputUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Select your Output unit:")) {
                    Picker("Select your Output Unit", selection: $outputUnitIndex) {
                        ForEach (0..<outputUnits.count) {
                            Text("\(self.outputUnits[$0])")
                        }
                    }
                }.pickerStyle(SegmentedPickerStyle())
                Section {
                    Text("Conversion Result: \(conversionResult, specifier: "%.1f")")
                        .bold()
                }
            }.navigationBarTitle("Unit Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
