//
//  ContentView.swift
//  WeSplit
//
//  Created by Ranjit on 17/08/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

struct ContentView_Form_Ex: View {
    var body: some View {
        /*
         Notes:
        1)Limitations upto 10 items in "Form" as straight forward.
            1.1)Forms also can be a Scrollable
        2)But if you want to add more than 10 then add as "Group"
        3)And if you want the group should be separated one, the go for "Section"
        4)When you scroll at top most of the screen, you will be able to see the first section values going beyond the screen. thats fine but its looks ugly. thats where the "NavigationView" plays the Role.
            4.1)After added the NavigationView its looks fine. but it will looks so empty there, there we have to add "NavigationBar" to have some set of decent title.
            4.2)By default Swift takes larger text. if you want you can customise with `displaymode` inline param.
         */
        NavigationView {
            Form {
                Section {
                    Text("Hello, World!")
                    Text("Hello, World!")
                    Text("Hello, World!")
                    Text("Hello, World!")
                    Text("Hello, World!")
                    Text("Hello, World!")
                }
                Section {
                    Text("Hello, World!")
                    Text("Hello, World!")
                    Text("Hello, World!")
                    Text("Hello, World!")
                    Text("Hello, World!")
                }
            }
            .navigationBarTitle("SwiftUI")
        }
    }
}

struct ContentView_State_Ex: View {
    /*
     Note:
    - We cannot simply create one variable inside the ContentView_II and when some button tapped, we cannot keeps on increase. becuase this is STRUCT. Thats why the @State[This is called `PROPERTY WRAPPER`] plays the role here.
     - Whichever we are making the properties are @State those are taking out of struct and keeping some where acting as reference.
     - Generally Apple suggesting us to go with @State for simple variable store/retrive inside the self view. Thats why it enforces us to use private access control
     */
    @State private var tapCount = 0
    var body: some View {
        Button ("Tap Me :\(tapCount)") {
            self.tapCount += 1 //Straight away we cannot do it.
        }
    }
}

struct ContentView_Binding_Ex: View {
/*
 Notes:
     1)We cannot simply put one TextField inside the form or simply return the textfield to the body.
     2)Because Swift needs to have some binding value. whatever user's typing on the textfield. what do you want to do with it.
     3)Okay then can we go with @State some variable, Yeah it is 80% job is done. but there its need to tell two way binding. because whenever the property or textfield value changes. both parties should get updated.
 */
    @State private var name = ""
    var body: some View {
        Form {
            TextField("Enter your name", text: $name)
            //Why $ symbol is not needed here because we are just writting it.
            Text("Your name is \(name)")
        }
    }
}

//Complete Two Binding Example here,
struct ContentView_CreatingViews_Loops_Ex: View {
    let students = ["ranjith","jobs","mark"]
    @State var selectedStudent = "ranjith"
    var body: some View {
        Picker("Select your Student", selection: $selectedStudent) {
            ForEach(0..<students.count) {
                Text(self.students[$0])
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_CreatingViews_Loops_Ex()
    }
}
