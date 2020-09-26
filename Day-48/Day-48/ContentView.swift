//
//  ContentView.swift
//  Day-48
//
//  Created by Ranjit on 26/09/20.
//

import SwiftUI

//Day - 48
//Today's task is to watch the Video and observe the things around Swift
//https://vimeo.com/295238750

/* CHANGE
 
1)Decoding & Encoding Statergy
2)CaseIteratable
3)Random Element and get shuffled of array
4)Warning & Error message to indication
5)Extension Array where Element: Protocol //Here if the Element is custom type then it should match this protocol then only this extension will work
6)Environment check. #if targetEnvironment(simulator)
 Simulator!
#endif
 
*/

/* CODE
 
 1)Value Types
    Value Semantics => End result would be struct. but inside there could be a reference
 2)Optionals
    When you are return Nil, try to use enum and give specific reason for this nil. throw it
    CompactMap => when you are converting some list of values but in some case some value could not convert and gives nil, then this compact map silently ignore and give us result.
 3)Protocols
 4)Force unwraps
    Happily force unwranp following things. because most of the things you will catch at compile time,
    Dequeuing cell
    Instantiating from storyboards
    Reading the App bundle
    Building a Regular expression
    Loading a Hard coded URL
 
 /* Below code only works on debug mode
 func check() {
     if _isDebugAssertConfiguration() {
         if !_branchHint(condition(), expected: true) {
             _assertFailure("Assertion failed", message())
         }
     }
 }*/
 Even we can use Assert to crash the program
 5)Architecture
    MVVM -> C(Coordinator)
    MVC -> C(Coordinator)
 */

/* COMMUNITY
    
 Everyone has something to learn
 Everyone has something to teach
 
 */

struct ContentView: View {
    var body: some View {
        Text("Thanks! Paul")
            .padding()
    }
    
  
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
