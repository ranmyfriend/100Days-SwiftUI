//Learning Resource : https://www.hackingwithswift.com/100/swiftui
//Learner: @ranmyfriend
//Date: August 2.2020
//Subject: Swift
//Day - 1

import Foundation
import UIKit
import PlaygroundSupport

var str = "Hello, playground"

str = "Good bye."

var age = 30 //Here swift assigns the type of Int. ie. Short for Integer

var million = 8_000_9999 //Here if you have larger number, you can use underscore(_) to denote the number. That helps to be readable one.

age = 3_0

//Type Safety is flawless.
// The above one age we cannot assign "Hello String". it will throw an error. As our Project grows, swift knows which is possible and which is not. Nothing goes here like blind folded.

//age = "Hello" -->NOT POSSIBLE

//Multi Line Strings
//Below one just for going with multi line strings on the label.
var multiple1 = """
Hello How are you?
From this side
Ranjith!
"""

//The below one should not be break any set of strings and neatly we can view the strings on the label
var multiple2 = """
Hello How are you? \
From this side \
Ranjith!
"""

var burns = """
The best laid schemes
o' mice an' men
gang aft agley
"""

let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
label.numberOfLines = 0
label.text = multiple1
label.sizeToFit()

PlaygroundPage.current.liveView = label


//Doubles & Booleans

var pi = 3.141
var awesome = true

var oneInt = 1
var oneDouble = 1.0

//The below one is acceptable when it comes to our langauage but not in Swift. It wont mix match two different data types
//var resOne = oneInt + oneDouble

//String Interpolations

var score = 98

var scoreDesc = "Your score was \(score)"

//Constants

let name = "Jobs"

//name = "Steven" //We can't do this operation.

//Type Annotations

let lname = "kumar" //Here based on the value what we are assigning the lname capturing the datatype.
