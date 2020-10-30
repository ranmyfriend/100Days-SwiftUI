//
//  ContentView.swift
//  BetterRest
//
//  Created by Ranjit on 27/08/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

//Project 4: About how user taking up the better rest
//Here we are going to explore CORE ML & CREATE ML framework to Analyse the user sleep data to train the model, whether he took a better or not?
/*
 When do they want to wake up?
 Roughly how many hours of sleep do they want?
 How many cups of coffee do they drink per day?
 */

struct ContentView_Stepper: View {
    @State private var sleepHours = 8.0
    var body: some View {
        Stepper(value: $sleepHours, in: 4...12, step: 0.25) { //This 4...12 range is min and max we can pick our sleep time.
            //step: 0.25 is incrementing by 0.25 each time when you do minus and plus
            //And once you given value as Int then the step should not be given as double. both the datatype should match
            Text("\(sleepHours, specifier: "%g") hours") //Here we can user "%.2f" but it will should 8.00 also but we want only number after the decimal and neglect the zeros. Thats why the "%g" comes here.
                .accessibility(label: Text("\(sleepHours) sleep hours"))
        }
    }
}

struct ContentView_Date: View {
    @State private var wakeup = Date()
    var body: some View {
        /*
         Notes: The following way we can create a Date Picker.
         But there are two problems with date picker by default.
         1)The label => "Please enter a Date?" by default will comes on the left side, even if you give empty string also date picker will allocate same default space. it will look ugly. For this, we can put the Date Picker in the "Form"
         And if you dont want to put into the Form, then go with
         DatePicker("Please enter a Date?", selection: $wakeup).labelHidden()
         */
        /*DatePicker("Please enter a Date?", selection: $wakeup)*/
        
//        Form { //This looks much better than normal one. But there is some UI-Glitch will be appearing when it comes and goes
        //displayedComponents will give us an option what type of things you want to pick from the date.
        /*And also possible to give a range to pick the date BUT THIS IS OLD FASHIONED WAY.
        let today = Date()
        let tomorrow = Date().addingTimeInterval(86400) //In seconds of tomorrow
        let todayAndTomorrowRange = today ... tomorrow
         
         NEW ONE:
            in: Date().... //This will takes all future and today.
         => Date()...Date().addingTimeInterval(86400) //Today & Tomorrow thats it
         */
        DatePicker("Please enter a Date?", selection: $wakeup, in: Date()...Date().addingTimeInterval(86400)).labelsHidden()
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_Date()
    }
}
