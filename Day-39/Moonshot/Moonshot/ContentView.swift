//
//  ContentView.swift
//  Moonshot
//
//  Created by Ranjit on 10/09/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

//Project 8 Part one

//Resizing images to fit the screen using GeometryReader
//Topic-1
struct ContentView_1: View {
    var body: some View {
            VStack {
                GeometryReader { geometry in

                        Image("logo-large")
                        .resizable() //This is applicable instead of going with clipped(). but it will looks squashed
                            .aspectRatio(contentMode: .fit) //But this aspectRatio will place the image in decent look
                            
                            //geometry helps us to setting up the width instead of hardcoding the width.
                            .frame(width: geometry.size.width) //Even when we give the frame of 300 width and 300 height, even though the imageview it wil show as larger one. thats why we are adding the clipped.
            //                .clipped() //This modifier will do clip the content based on the frame
                    }
        }
    }
}

//How ScrollView lets us work with scrolling data
//Topic-2

struct ContentView_2: View {
    var body: some View {
        GeometryReader { geometry in
            /* `List` => it performs lazily to load or create the uielement at on demand
            But `ScrollView` => it will create or load the view instance immeditely. so in below example the 100 views will create immediately.
             */
            ScrollView(.vertical) { //This is how you can create a scrollview in SwiftUI. Here Veritical scroll indicator and scrolling is Addons
                VStack(spacing: 10) {
                    ForEach(0..<100) {
                        Text("Item:\($0)")
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .font(.title)
                        .frame(width: geometry.size.width, height: 50)
                        .padding()
                    }
                }
                .frame(maxWidth: .infinity) //This is increased the tappable area. so user can simply scroll out of textfield also the scrolling will happen. [USER FRIENDLY]
            }
        }
    }
}

/* Pushing new views onto the stack using NavigationLink */
//Topic:3

struct ContentView_3: View {
    var body: some View {
        NavigationView {
            List(0..<100) { row in
                //Pushing a new view from current view and can easily popped out from there using default back button or sliding gesture.
                NavigationLink(destination: Text("Detail \(row)")) {
                    Text("Row \(row)") //This Hello World textview looks like a Button, because of there a destination view attached to this as action.
                }
            }
            .navigationBarTitle("Swift UI")
        }
    }
}

/* Working with hierarchical Codable data */
//Topic:4

struct ContentView_4: View {
    var body: some View {
        Button("Decode JSON") {
            let input = """
                        {
                        "name": "ranjith",
                        "address": {
                        "street": "555, Patellama layout",
                        "city": "ABC"
                        }

                        }

                        """
            /*There’s no limit to the number of levels Codable will go through – all that matters is that the structs you define match your JSON string.*/
            struct User: Codable {
                var name: String
                var address: Address
            }
            struct Address: Codable {
                var street: String
                var city: String
            }
            
            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: data) {
                print(user.address)
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_4()
    }
}
