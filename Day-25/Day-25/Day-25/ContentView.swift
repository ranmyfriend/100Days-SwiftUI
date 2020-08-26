//
//  ContentView.swift
//  Day-25
//
//  Created by Ranjit on 26/08/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var developers = ["Mark","Juice","Lusie"]
    
    var body: some View {
        VStack {
            
            ForEach (0..<10) { i in //struct ForEach<Data, ID, Content> this is what ForEach. This is not a Loop this is also kind of View which creates subviews in using range
                Text("Hello, World!:\(i)")
            }
            Section(header: Text("Developers:")) {
                ForEach (developers, id:\.self) {
                    Text($0)
                }
            }
        }
    }
}

struct ContentView_Binding: View {
    @State var selection = 0

    var body: some View {
        let binding = Binding( //This is what it happens behind the scenes of using the @State property. SwiftUI handles everything but if you want to control however you want, you can use Binding like this.
            get: { self.selection },
            set: { self.selection = $0 }
        )

        return VStack {
            Picker("Select a number", selection: binding) {
                ForEach(0 ..< 3) {
                    Text("Item \($0)")
                }
            }.pickerStyle(SegmentedPickerStyle())
        }
    }
}


struct ContentView_Challenge: View {
    //Paper->Rock - add score - win
    //Scissors->Paper - add score - win
    //Other way lost
    private var possibleMoves = ["Rock", "Paper", "Scissors"]
    @State private var userChoice = -1
    @State private var score = 0
    @State private var winLose = false
    @State private var status = ""
    @State var gameStarted = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text(self.userChoice == -1 ? "Select any one of the possible move?" : "The player tapped \(possibleMoves[userChoice])")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                Button(action: {
                    if self.userChoice == -1 {
                        self.userChoice = 0
                    } else {
                        let chosen = self.possibleMoves[self.userChoice]
                        self.userChoice = 0
                        self.choiceChosen(lastChosen: chosen)
                    }
                }) {
                    Text(self.possibleMoves[0])
                        .frame(width: 200, height: 50)
                        .foregroundColor(Color.white)
                        .background(Color.black)
                }
                
                Button(action: {
                    if self.userChoice == -1 {
                        self.userChoice = 1
                    } else {
                        let chosen = self.possibleMoves[self.userChoice]
                        self.userChoice = 1
                        self.choiceChosen(lastChosen: chosen)
                    }
                }) {
                    Text(self.possibleMoves[1])
                        .frame(width: 200, height: 50)
                        .foregroundColor(Color.white)
                        .background(Color.black)
                }
                
                Button(action: {
                    if self.userChoice == -1 {
                        self.userChoice = 2
                    } else {
                        let chosen = self.possibleMoves[self.userChoice]
                        self.userChoice = 2
                        self.choiceChosen(lastChosen: chosen)
                    }
                }) {
                    Text(self.possibleMoves[2])
                        .frame(width: 200, height: 50)
                        .foregroundColor(Color.white)
                        .background(Color.black)
                }
                
                Text("Player score: \(score)")
                        .font(.largeTitle)
                        .foregroundColor(.pink)
                if gameStarted {
                    Text("You \(self.status)")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                }
            }
        .navigationBarTitle("25th Day - Challenge")
        }
    }
    
    func choiceChosen(lastChosen: String) {
        self.gameStarted = true
        //Paper->Rock - add score - win
        //Scissors->Paper - add score - win
        //Other way lost
        let move = possibleMoves[self.userChoice]
        if lastChosen == "Paper" && move == "Rock" || lastChosen == "Rock" && move == "Paper"{
            self.score += 1
            self.winLose = true
            self.status = "Win"
        } else if lastChosen == "Scissors" && move == "Paper" || lastChosen == "Paper" && move == "Scissors" {
            self.score += 1
            self.winLose = true
            self.status = "Win"
        } else {
            self.score = 0
            self.winLose = false
            self.status = "Lose"
        }
        
        self.userChoice = -1
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_Challenge()
    }
}
