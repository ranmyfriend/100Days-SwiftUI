//
//  ContentView.swift
//  iExpense
//
//  Created by Ranjit on 07/09/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

//Project 7 Part one
//Expense Tracker

/* TOPIC -1 : Why @State only works with structs*/

/*
 Notes:
 Why @State only works with structs
 Because @State works fine with one single view, and wheever the struct changes using @State property, then which ever it relatest to the UI Element get updated.
 But What if i want to pass this struct into another screen, and there if i want to update soemthing on to this struct, will it get reflected on the screen 1. The Answer is BIG NO. Because both the screens have their own copy of the structs. This is disadvantages and primarily apple they have designed it in a such way to work with single view.
 */

struct User { //Here what if i change struct as class. will it work?
    /*
     NOOOOOO => It wont work. because SwiftUI take cares of creating new set of instance and when the mutating happens on every properties. when it goes with struct. But in class the property can change easily. Because of this is reference. but swiftUI wont reload the view. It wont create that much attention how it was for struct. :P
     
     But when you want to achieve this to reload the view automatically use new keyword called @ObservedObject
     */
    var fName: String = "Ranjith"
    var lName: String = "Kumar"
}

struct ContentView_TOPIC_1: View {
    @State private var user = User()
    
    var body: some View {
        VStack {
            Text("First Name: \(user.fName) and Last Name: \(user.lName)")
            
            TextField("\(user.fName)", text: $user.fName)
            
            TextField("\(user.lName)", text: $user.lName)
        }
    }
}

/* TOPIC - 2: Sharing SwiftUI state with @ObservedObject*/

/* 3 Steps to address the @State behaviour reflection on class
 1)Make class to confirm the ObservableObject Protocol
 2)Mark property as @Published
 3)Mark user object as @ObservedObject
 */

class User_2: ObservableObject /// The type of publisher that emits before the object has changed.
{
    @Published var fName: String = "Ranjith" //@Published Keyword intimates to the SwiftUI whatever the changes happens to this property, immediately reload the view
    @Published var lName: String = "Kumar"
}
struct ContentView_TOPIC_2: View {
    @ObservedObject private var user = User_2()
    
    var body: some View {
         VStack {
                 Text("First Name: \(user.fName) and Last Name: \(user.lName)")
                 
                 TextField("\(user.fName)", text: $user.fName)
                 
                 TextField("\(user.lName)", text: $user.lName)
             }
    }
}

/* TOPIC 3: SHOWING VIEWS & HIDING VIEWS*/

struct SecondView: View {
    //Is the user in light mode or dark mode? Have they asked for smaller or larger fonts? What timezone are they on? All these and more are values that come from the environment, and in this instance we’re going to read our view’s presentation mode from the environment.
    
    /* /// A `Binding` to the current `PresentationMode` of this view.*/
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Button("Dismiss") {
            //This is how can we can dismiss the our own view from some button action.
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ContentView_TOPIC_3: View {
    @State private var showingSheet = false
    
    var body: some View {
        Button("Show Sheet") {
            self.showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) { //If you want to present a view as a screen. User this sheet function. and its written in View Extension. So which ever the UI component can use function to present a view
            SecondView()
        }
    }
}


/* TOPIC 4: Deleting items using onDelete() */

struct ContentView_TOPIC_4: View {
    /* SwiftUI Extensively works on delete and adding rows with List or ForEach */
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    /* Notes:
                     List(numbers, id: \.self) {
                         Text("\($0)")
                     }
                     The above code is Modified one and we can say: ForEach is not needed here but in SwiftUI, onDelete is only applicable on ForEach. So you must use ForEach
                     */
                    ForEach(numbers, id:\.self) {
                        Text("\($0)")
                    }
                .onDelete(perform: removeRows) //This enables the Swipe To Delete functionality as well as in the UI
                }
                
                Button("Add Number") {
                    self.numbers.append(self.currentNumber)
                    self.currentNumber += 1
                }
            }
            .navigationBarItems(leading: EditButton())
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        self.numbers.remove(atOffsets: offsets)
    }
}

/* TOPIC 5: Storing user settings with UserDefaults*/
/* One Big disadvantages on UserDefaults. it will take some time to store it automatically.*/
struct ContentView_TOPIC_5: View {
    
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap.Count")
    
    var body: some View {
        Button("Tap Count:\(tapCount)") {
            self.tapCount += 1
            UserDefaults.standard.set(self.tapCount, forKey: "Tap.Count")
        }
    }
}

/* TOPIC 6: Archiving Swift objects with Codable*/

struct User1: Codable {
    var fName: String
    var lName: String
}

struct ContentView_TOPIC_6: View {
    @State private var user = User1(fName: "Ranjith", lName: "Kumar")
    @State private var retrivedUser: User1 = User1(fName: "", lName: "")
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Save User") {
                let encoder = JSONEncoder()
                if let data = try? encoder.encode(self.user) {
                    UserDefaults.standard.set(data, forKey: "User.Data")
                }
            }
            Button("Retrive User") {
                let decoder = JSONDecoder()
                let userData = UserDefaults.standard.object(forKey: "User.Data") as? Data
                if let data:User1 = try? decoder.decode(User1.self, from: userData! ) {
                    self.retrivedUser = data
                }
            }
            Text("\(retrivedUser.fName) \(retrivedUser.lName)")
        }
      
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_TOPIC_2()
    }
}
