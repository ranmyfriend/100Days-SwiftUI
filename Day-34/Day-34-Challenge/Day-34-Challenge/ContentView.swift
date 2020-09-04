//
//  ContentView.swift
//  Day-34-Challenge
//
//  Created by Ranjit on 04/09/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

//This is a Challenge for applying the Animations on GuessTheFlag Project
/*
When you tap the correct flag, make it spin around 360 degrees on the Y axis.
Make the other two buttons fade out to 25% opacity.
And if you tap on the wrong flag? Well, that’s down to you – get creative!
*/

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled() //This Shuffle will automatically take cares of ordering in randomized.
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var isCorrectAnswer = false
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMsg = ""
    @State private var userScore = 0
    @State private var rotationDegress:Double = 0.0
    @State private var opactiy = 1.0
    
    var body: some View {
        ZStack { //ZStack uses to put something background color on the content background
            LinearGradient(gradient: Gradient(colors: [.blue,.black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        withAnimation {
                            if self.isCorrectAnswer {
                                self.rotationDegress += 360
                                self.opactiy = 1.0
                            } else {
                                self.rotationDegress = 0
                                self.opactiy = 0.25
                            }
                        }
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)//The renderingMode(.original) modifier tells SwiftUI to render the original image pixels rather than trying to recolor them as a button.
                        .clipShape(Capsule()) //Adding the Shape to the button. [4 built in shape] 1)Rectangle 2)Rounded Rectangle 3)Circle 4)Capsule
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1)) //Here it will ad black color overlay with 1 width on top of clip edges #Shadow effect
                            .shadow(color: .black, radius: 2) //If you dont give x then it will automatically takes x as 0
                    }
                    .rotation3DEffect(.degrees(self.rotationDegress), axis: (x: 0, y: 1, z: 0))
                    .opacity(self.opactiy)
                }
            }
            Spacer() //this spacer will help us to move the content towards the top
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle),
                  message: Text(scoreMsg),
                  dismissButton: .default(Text("Continue ")) {
                    self.askQuestion()
                    self.opactiy = 1.0
                })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
            scoreMsg = "Your score is \(userScore)"
            isCorrectAnswer = true
        } else {
            scoreTitle = "Wrong"
            if userScore > 0 {
                userScore -= 1
            }
            scoreMsg = "That’s the flag of \(countries[number])"
            isCorrectAnswer = false
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Dummy: View {
    @State private var tapped = false
    var body: some View {
        Button("Tap Me") {
            self.tapped.toggle()
        }
        .rotationEffect(.degrees( tapped ? -90 : 0))
    }
}

struct FlagView: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.largeTitle)
    }
}

extension View {
    func flagStyle() -> some View {
        self.modifier(FlagView())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_Dummy()
    }
}
