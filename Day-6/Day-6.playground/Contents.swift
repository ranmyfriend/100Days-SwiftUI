//Learning Resource : https://www.hackingwithswift.com/100/swiftui
//Learner: @ranmyfriend
//Date: August 7.2020
//Subject: Swift
//Day - 6
//Closures, part one

import Foundation

//Creating Basic Closures
//Below are some scenarios when closures are actually needed.
//Running some code after a delay.
//Running some code after an animation has finished.
//Running some code when a download has finished.
//Running some code when a user has selected an option from your menu.

let driving = {
    print("I am driving in a Car")
}

driving()

//Accepting Parameters in a Closure
//Closures will take parameters inside the brace
//Closures cannot use external labels on parameters

let driving1 = { (place: String) in
    print("CLOSURE:I am driving to \(place)")
}

driving1("Vellore")

//Cross check with function syntax by following same function
func driving1(place: String) {
    print("FUNC:I am driving to \(place)")
}

driving1(place: "Vellore")


//Returning values from a closure

let drivingWithReturn = { (place: String) -> String in
     "I am driving to \(place)"
}

drivingWithReturn("Peenya")

//No Parameters and return

let simpleReturn = { () -> Bool in
    true
}

simpleReturn()

//Closures as parameters
//The following one we can tweak some set of clousre code snippet at on demand
let driving3 = {
    print("I am driving")
}

func travel(action: () -> Void) {
    print("Travel started")
    action()
    print("Travel ended")
}

travel(action: driving3)

//Trailing closure syntax
//If the last parameter to a function is a closure, Swift lets you use special syntax called trailing closure syntax. Rather than pass in your closure as a parameter, you pass it directly after the function inside braces.

//Beautiful Syntax
func travel1(action: () -> Void) {
    print("Travel has started")
    action()
    print("Travel has ended")
}

travel1 {
    print("Travelling in a Car")
}

