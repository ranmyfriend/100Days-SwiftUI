//
//  ContentView.swift
//  Instafilter
//
//  Created by Ranjit on 13/10/20.
//

import SwiftUI

//Day - 62
//1)How property wrappers become structs
//2)Creating custom bindings in SwiftUI
//3)Showing multiple options with ActionSheet

struct ContentView: View {
    /*
     If you look at the debugger window, we wont be able to get the blurAmount print stmts. because in SwiftUI @State is a Property Wrapper Struct. struct itself never changes. behinds the scenes the swiftUI sends this value to the storage in a place where it can be modified freely.
     public var wrappedValue: Value { get nonmutating set }
     
     State wraps its value using a non-mutating setter, which means neither blurAmount or the State struct wrapping it are changing – our binding is directly changing the internally stored value, which means the property observer is never being triggered.
     
     SOLUTION: CUSTOM BINDING STRUCT or BINDING VARIABLE
     
     */
    @State private var blurAmount: CGFloat = 0.0 {
        didSet {
            print("blurAmount:\(blurAmount)")
        }
    }
    
    var body: some View {
        
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },

            set: {
                self.blurAmount = $0
                print("New value is:\(self.blurAmount)")
            }
        )
        
    VStack {
            Text("Hello, world!")
                .blur(radius: blurAmount)
                .padding()
            
//            Slider(value: $blurAmount, in: 0...20) //@State two way binding property used
        Slider(value: blur, in: 0...20)
        
        }
    }
}

struct ContentView_2: View {
    
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Text("Hello World")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                self.showingActionSheet = true
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Change Background"), message: Text("Select a new color"), buttons: [
                    .default(Text("Red")) {
                        self.backgroundColor = .red
                    },
                    .default(Text("Green")) {
                        self.backgroundColor = .green
                    },
                    .default(Text("Blue")) {
                        self.backgroundColor = .blue
                    },
                    .cancel()
                ])
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
