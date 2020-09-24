//
//  Day_47App.swift
//  Day-47
//
//  Created by Ranjit on 24/09/20.
//

import SwiftUI

@main
struct Day_47App: App {
    var body: some Scene {
        WindowGroup {
            return ContentView(habits: habit)
        }
    }
    
    var habit: Habits {
        let habitsModel = Habits()
        habitsModel.listOfHabits = habits
        return habitsModel
    }
    
    var habits: [Habit] {
        let cycleHabit = Habit(id: 1, name: "Cycling", description: "Daily Morning i used to go for ride at 7am.")
        let yogaHabit = Habit(id: 2, name: "Yoga", description: "Daily Evening i used to do yoga around 1hour")
        let sleepHabit = Habit(id: 3, name: "Sleep", description: "Daily Evening i used to take 45min snap after reached home from office")
        return [cycleHabit, yogaHabit, sleepHabit]
    }
}
