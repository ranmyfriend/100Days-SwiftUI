//
//  CreateHabitView.swift
//  Day-47
//
//  Created by Ranjit on 25/09/20.
//

import SwiftUI

struct CreateHabitView: View {
    @State private var name: String = ""
    @State private var desc: String = ""
    @ObservedObject var habits: Habits
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your habit name?", text: $name)
                    .padding()
                    .disableAutocorrection(true)
                TextField("Enter your habit description?", text: $desc)
                    .padding()
                Button("Done") {
                    let id = Array(10...100).randomElement()!
                    let habit = Habit(id: id, name: name, description: desc)
                    habits.listOfHabits.append(habit)
                    self.presentationMode.wrappedValue.dismiss()
                }
                .font(.body)
            }
            .navigationTitle("Create Habit")
        }
    }
}

struct CreateHabitView_Previews: PreviewProvider {
    static var previews: some View {
        let habitsModel = Habits()
        habitsModel.listOfHabits = habits
        return CreateHabitView(habits: habitsModel)
    }
    
    static var habits: [Habit] {
        let cycleHabit = Habit(id: 1, name: "Cycling", description: "Daily Morning i used to go for ride at 7am.")
        let yogaHabit = Habit(id: 2, name: "Yoga", description: "Daily Evening i used to do yoga around 1hour")
        let sleepHabit = Habit(id: 3, name: "Sleep", description: "Daily Evening i used to take 45min snap after reached home from office")
        return [cycleHabit, yogaHabit, sleepHabit]
    }
}
