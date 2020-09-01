//
//  ContentView.swift
//  Day-31-Challenge
//
//  Created by Ranjit on 01/09/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

//This is Project 5 part 3
//Challenge project

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var userScore = 0
    
    @State private var errorTitle = ""
    @State private var errorMsg = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord) //- onCommit: The action to perform when the user performs an action
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                List(usedWords, id:\.self) {
                    Image(systemName: "\($0.count).circle") //This will shows the count of word in SF Circle image
                    Text($0)
                }
                
                Text("Player Score: \(userScore)")
                    .font(.largeTitle)
                    .foregroundColor(Color.pink)
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(leading:
                Button(action: startGame) {
                    Text("Start Game")
                })
            .onAppear(perform: startGame) //This is a dedicated view modifer when view has shown and we can call some methods in closure.
                .alert(isPresented: $showingError) {
                    Alert(title: Text(errorTitle), message: Text(errorMsg), dismissButton:.default(Text("OK")))
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {
            return
        }
        
        guard isOrginal(word: answer) else {
            wordError(title: "Word used already", msg: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognised", msg: "you can't just make them up, you know!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", msg: "That's not a real word")
            return
        }
        
        usedWords.insert(answer, at: 0)
        newWord = ""
        userScore += 1
    }
    
    func clear() {
        newWord = ""
        userScore = 0
        usedWords.removeAll()
    }
    
    func startGame() {
        clear()
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("could not load start.txt file from bundle")
    }
    
    func isOrginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        guard word.count < 3 || rootWord != word else {
            return false
        }
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, msg: String) {
        errorTitle = title
        errorMsg = msg
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
