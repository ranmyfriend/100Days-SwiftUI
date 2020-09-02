//
//  ContentView.swift
//  Animations
//
//  Created by Ranjit on 02/09/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

//Project 6 part 1
//Animations

struct ContentView: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        Button(action: {
//            self.animationAmount += 1
        }, label: {
            Text("Tap Me")
        })
            .padding(50)
            .background(Color.red)
            .foregroundColor(Color.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.red)
                .scaleEffect(animationAmount)
                .opacity(Double(2-animationAmount))
                .animation(
                        Animation.easeInOut(duration: 2)
                            .repeatForever(autoreverses: false) //Here how many times you want to repeat the animation in autoreverse mode and also there a repeatForever is there to keeps on repeat the animation
                )
        )
            //.scaleEffect(animationAmount) //Here the animation we are trying with help of scaling effect
            //.blur(radius: (animationAmount - 1) * 3)//A radius of (animationAmount - 1) * 3 means the blur radius will start at 0 (no blur), but then move to 3 points, 6 points, 9 points, and beyond as you tap the button.
            //.animation(.default) //Adding this simple animation makes the scaling in very smooth
            //.animation(.easeOut(duration: 2)) //This is how we can give duration on top of the animation
//        .animation(
//            Animation.easeInOut(duration: 2)
//                .repeatCount(2, autoreverses: true) //Here how many times you want to repeat the animation in autoreverse mode and also there a repeatForever is there to keeps on repeat the animation
//        )
            .onAppear {
                self.animationAmount = 2 //This value we are passing to the overlay and it will keeps on animate
        }
    }
}

struct ContentView_Animation2:View {
    @State private var animationAmount: CGFloat = 1
    var body: some View {
        print(animationAmount) //When you go for different statements then you must use return keyword to send back to body with respective view
        
        return VStack {
            //Here the Tap Me button scale based on the stepper value.
            Stepper("Stepper Amount", value: $animationAmount.animation(
                Animation.easeOut(duration: 2).repeatCount(2, autoreverses: true)
            ) /* Here .animation will take default one. but if you want we can add easeIn or easeOut animations too*/, in: 1...10)
            
            Spacer()
            
            Button("Tap Me") {
                self.animationAmount += 1
            }
            .padding(40)
            .background(Color.red)
            .foregroundColor(Color.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }
}


//Here we are creating tap me button and adding 3d animation
struct ContentView_ExplictAnimation: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
        Button("Tap Me") {
            //Here we are adding the spring animation to make the spin should bit of smoother.
            withAnimation (.interpolatingSpring(stiffness: 5, damping: 1)) {
                self.animationAmount += 360 //it will spin one full circle
            }
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(Color.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_ExplictAnimation()
    }
}
