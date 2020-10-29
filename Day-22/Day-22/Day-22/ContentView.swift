//
//  ContentView.swift
//  Day-22
//
//  Created by Ranjit on 23/08/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

//Challenge on Day-21 to complete the Day-22
/*
 Add an @State property to store the user’s score, modify it when they get an answer right or wrong, then display it in the alert.
 Show the player’s current score in a label directly below the flags.
 When someone chooses the wrong flag, tell them their mistake in your alert message – something like “Wrong! That’s the flag of France,” for example.
 */

struct ContentView: View {
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled() //This Shuffle will automatically take cares of ordering in randomized.
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMsg = ""
    @State private var userScore = 0
    
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
                            .accessibility(label: Text(self.labels[self.countries[number], default: "Unknown flag"]))
                    }
                }
            }
            Spacer() //this spacer will help us to move the content towards the top
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle),
                  message: Text(scoreMsg),
                  dismissButton: .default(Text("Continue ")) {
                    self.askQuestion()
                })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
            scoreMsg = "Your score is \(userScore)"
        } else {
            scoreTitle = "Wrong"
            if userScore > 0 {
                userScore -= 1
            }
            scoreMsg = "That’s the flag of \(countries[number])"
        }
        showingScore = true
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
