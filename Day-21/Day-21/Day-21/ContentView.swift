//
//  ContentView.swift
//  Day-21
//
//  Created by Ranjit on 22/08/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

//Project 2, part 2

//Lessons topics below
//1.Stacking up Buttons
//2.Showing the player’s score with an alert
//3.Styling our flags

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled() //This Shuffle will automatically take cares of ordering in randomized.
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
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
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)//The renderingMode(.original) modifier tells SwiftUI to render the original image pixels rather than trying to recolor them as a button.
                        .clipShape(Capsule()) //Adding the Shape to the button. [4 built in shape] 1)Rectangle 2)Rounded Rectangle 3)Circle 4)Capsule
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1)) //Here it will ad black color overlay with 1 width on top of clip edges #Shadow effect
                            .shadow(color: .black, radius: 2) //If you dont give x then it will automatically takes x as 0
                    }
                }
            }
            Spacer() //this spacer will help us to move the content towards the top
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle),
                  message: Text("Your score is ???"),
                  dismissButton: .default(Text("Continue ")) {
                    self.askQuestion()
                })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
