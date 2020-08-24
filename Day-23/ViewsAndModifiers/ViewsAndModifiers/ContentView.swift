//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Ranjit on 24/08/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

//Project 3, part 1
/* ---Below notes are taken. not copy pasted :P----
 Why does SwiftUI use structs for views?
    1)Power of Elements. Using structs are very simple but its very powerful in the bigger picture
    2)In UIKit or AppKit, UIView base class will give all of the basic functionality to the UIButton and UIView, UILabel. So when you are going adopt any set of UI based subclas all of the pre built functionalties all come along. This is called inheritance. but in SwiftUI, There is NO MAGIC. All things are very handy and also its creating by you. And its works very fast and no hidden things.
    3)Its copy of the objects & properties. No messy and you freely can play with any set of code you want to achieve
    4)When you are desinging a View, all of the things are in our control. Thats how it forces to go with how the data control should happen when it comes to each and every UI component.
    5)If you look at the UIView Documentation there are very very bulky methods and properties and all things are passed to custom subclass. But in SwiftUI only needed things are avialable and also very very trivial. like if you are creating Color.Red This will give one simply view which has backgrould color as red. Thats it. No more info
 */

/*
 What is behind the main SwiftUI view?
    Nothing here. You should go with content
 */

/*struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity)
            .background(Color.red) //Here background function accpet one view, So color.red returns a View with red color and adding one textview into that
            .edgesIgnoringSafeArea(.all)
    }
}*/

/*
 Why orders are matters in SwiftUI?
 //Print Stmt: ModifiedContent<ModifiedContent<Button<Text>, _BackgroundModifier<Color>>, _FrameLayout>

 If you look at the print output. Its clealy says button takes Text and applies some background color, and then changing the framelayout. Thats why even if you are trying to change the frame width and height also does not reflect here. This is the reason behind the Order.
 */

/*
 struct ContentView: View {
    var body: some View {
        Button("Hello Tap Me") {
            //Tapped
            print(type(of:self.body))
        }
        .background(Color.red)
        .frame(width: 200, height: 100)
    }
}*/

/*
 Why does SwiftUI use “some View” for its view type?
 ContentView is confirms to the View protocol and it does not care about the type of body. Because it is Associated Type of generics
 */

/*
 Conditional modifiers
 */

/*
struct ContentView: View {
    @State private var userRead = false
    var body: some View {
    
         /* The below code is completely Acceptable the reason is the opaque type is Button is going to return it*/
        Button("User Read") {
            self.userRead.toggle()
        }
        .foregroundColor(userRead ? .blue : .red)
 
        /* The below code is un-acceptable
            Reason here is: if condition is returning TextView but else condition returns a ModifierView. So both should confirm one same data type*/
        /*
         if userRead {
            return Text("Hey")
        } else {
            return Text("Hey").background(Color.red)
        }*/
    }
}
 */

/* Environment Modifiers*/

/*
struct ContentView: View {
    var body: some View {
        VStack {
            Text("iOS")
                .font(.largeTitle) //But if you want to change some particular childview font. you can do like this. and this will be the first priority
            Text("Android")
            Text("Backend")
        }
        .font(.title) //When i apply the font, it will apply all of the textviews inside the VStack called Environment Modifiers
    }
}
 */

/* View Composition
 some set of common things we can move into one struct and then we can reuse the functionality for differnt UI elements
 */

/*
struct RoundedView: View {
    var text: String
    var body: some View {
        Text(text)
            .clipShape(Capsule())
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            RoundedView(text: "Hello")
                .foregroundColor(.red)
            RoundedView(text: "World")
            .foregroundColor(.blue)
        }
    }
}
 */

/* Custom Modifiers
 SwiftUI gives us a range of built-in modifiers, such as font(), background(), and clipShape(). However, it’s also possible to create custom modifiers that do something specific.

 For example, we might say that all titles in our app should have a particular style, so first we need to create a custom ViewModifier struct that does what we want:
 */
/*struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello World")
            .titleStyle()
    }
}
 */

/* Custom containers */

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

   var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        GridStack(rows: 4, columns: 4) { row, col in
            HStack {
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
