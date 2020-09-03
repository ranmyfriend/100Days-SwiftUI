//
//  ContentView.swift
//  Day-33
//
//  Created by Ranjit on 03/09/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

//Animations
//Project 6 Part 2

//Demo-1: Controlling the Animations Stack

struct ContentView_Demo_1: View {
    @State private var enabled = false
    var body: some View {
        Button("Tap Me") {
            self.enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? Color.blue : Color.red)
        //.animation(.default) //How many animations if you want you can add and also. each individual we can represent differnt animations too
            .animation(nil) //And if you want to disable the animation then we can simply passing nil. it can be done. here the color change will do as fast without animation
        .foregroundColor(Color.white) //In SwiftUI orders matters like when i apply animation before clipShape then cornerRadius wont animate. but if i apply in last, then you clipshape also will animate
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
            .animation(.interpolatingSpring(stiffness: 10, damping: 1))
    }
}

//Demo-2: Animating gestures
struct ContentView_Demo_2: View {
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
            
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(dragAmount) //This offset method is dedicate for adjusting x and y
            .gesture (
                DragGesture()
                    .onChanged { self.dragAmount = $0.translation }
                    .onEnded { _ in //This is Explict animation. it will only applies on ended.
                        withAnimation(.spring()) {
                            self.dragAmount = .zero }
                }
        )
           // .animation(.spring()) //Here Spring() is Implict animation it will apply on coordinates change
    }
}

//Demo 2 continutation:
struct ContentView_LettersAnimation: View {
     let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in
                Text(String(self.letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(self.enabled ? Color.blue : Color.red)
                    .offset(self.dragAmount) //It helps to change the x and y based on the dragAmount changes
                    .animation(Animation.default.delay(Double(num)/20)) //Here we are adding the delay
            }
        }
        .gesture(
            DragGesture()
                .onChanged {
                    self.dragAmount = $0.translation
            }
            .onEnded { _ in
                self.dragAmount = .zero
                self.enabled.toggle() //Each time when you ended the drag animation it will change the color
            }
        )
    }
}

//Demo-3:Showing and hiding views with transitions

struct ContentView_Transition: View {
    @State private var showingRed = false
    
    var body: some View {
        VStack { //by default Stack rearranging the views.
            Button("Tap Me") {
                withAnimation { //Here withAnimation it will look decent enough
                    self.showingRed.toggle()
                }
            }
            if showingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    //.transition(.scale) //This is custom transition. the width and height will increase and decrease with scale effect
//                    .transition(.asymmetric(insertion: .scale, removal: .opacity)) //this will apply the transion when enlarge and when decreaing the size, it will loose the opacity [Basically one is appearing and another one is disappearing]
                    .transition(.pivot) //This is cutom transition created in Demo-4
            }
        }
    }
}

//Demo-4:Building custom transitions using ViewModifier

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor)
            .clipped() //Clipped() means that when the view rotates the parts that are lying outside its natural rectangle don’t get drawn.
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        //Here we are rotating from -90 to 0 on the topTrailing
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topTrailing), identity: CornerRotateModifier(amount: 0, anchor: .topTrailing))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_Transition()
    }
}
