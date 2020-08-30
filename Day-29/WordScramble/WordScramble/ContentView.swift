//
//  ContentView.swift
//  WordScramble
//
//  Created by Ranjit on 30/08/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

//Project 5 Part One

struct ContentView_ListView: View {
    var body: some View {
        VStack {
            //List is equivalent to UITableView in UIKit
            List { //'List' helps to create list of items which are going to be a Static list then what if i want to a dynamic one thats where the 'ForEach' comes
                Section(header: Text("Section - 1")) {
                    Text("Static Row 1")
                    Text("Static Row 2")
                }
                Section(header: Text("Section -2")) {
                    ForEach (0..<5) {
                        Text("Dynamic row:\($0)")
                    }
                }
                Section(header: Text("Section-3")) {
                    Text("Static Row 3")
                    Text("Static Row 4")
                }
            }
            .listStyle(GroupedListStyle()) //This is exactly looks like 'Form'
            
            List(0..<5) { //This is completely dynamic rows without having form
                Text("Hello Dynamic Row:\($0)")
            }
            .listStyle(GroupedListStyle())
        }
    }
}

struct ContentView_Bundle: View {
    var body: some View {
        //This is how you can load any set of file from the bundle. here we are loading it from Main Bundle.
        if let file =  Bundle.main.url(forResource: "Info", withExtension: "plist") {
            let string = try? String(contentsOf: file)
            
            //Strings
            let input = """
a
b
c
"""
            let letters = input.components(separatedBy: "\n")
            let letter = letters.randomElement()
            let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            
            let word = "swift"
            let checker = UITextChecker()
            
            let range = NSRange(location: 0, length: word.utf16.count)
            
            let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
            let allGood = misspelledRange.location == NSNotFound

            
            return allGood ? Text("letters are:\(trimmed)") : Text("Not Good")
        } else {
            return Text("No File")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_Bundle()
    }
}
