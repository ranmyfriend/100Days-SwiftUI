//
//  ContentView.swift
//  Day-47
//
//  Created by Ranjit on 24/09/20.
//

import SwiftUI

//Day - 47
//Challenge Project
//https://www.hackingwithswift.com/guide/ios-swiftui/4/3/challenge

//Todo:
//Create a New Habit
//Delete a Habit
//Add a count of times user completed the habit

struct Habit: Identifiable {
    let id: Int
    let name: String
    let description: String
    var activityCount: Int = 0
}

class Habits: ObservableObject {
    @Published var listOfHabits: [Habit] = []
}

struct ContentView: View {
    @ObservedObject var habits: Habits
    
    var body: some View {
        NavigationView {
            Form {
                List(habits.listOfHabits) { habit in
                    VStack {
                        Text(habit.name)
                            .padding()
                            .font(.system(size: 17))
                            .foregroundColor(Color.black)
                    }
                    Text(habit.description)
                        .padding()
                        .font(.system(size: 15))
                        .foregroundColor(Color.gray)
                }
            }
            .navigationBarItems(trailing: Button("Create") {
                print("Todo")
            })
            .navigationBarTitle("Habit Tracking App")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let habitsModel = Habits()
        habitsModel.listOfHabits = habits
        return ContentView(habits: habitsModel)
    }
    
    static var habits: [Habit] {
        let cycleHabit = Habit(id: 1, name: "Cycling", description: "Daily Morning i used to go for ride at 7am.")
        let yogaHabit = Habit(id: 2, name: "Yoga", description: "Daily Evening i used to do yoga around 1hour")
        let sleepHabit = Habit(id: 3, name: "Sleep", description: "Daily Evening i used to take 45min snap after reached home from office")
        return [cycleHabit, yogaHabit, sleepHabit]
    }
}
