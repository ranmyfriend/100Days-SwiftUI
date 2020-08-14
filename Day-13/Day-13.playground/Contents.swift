//Learning Resource  https://www.hackingwithswift.com/100/swiftui
//Learner: @ranmyfriend
//Date: August 14.2020
//Subject: Swift
//Day - 13
//Recap of
/*  - Variables & Constants
    - Types of Data
    - Operators
    - String Interpolation
    - Arrays
    - Dictionaries
    - Conditional Statements
    - Loops
    - Switch case
*/

import Foundation

//Variables & Constants

//Varaible can change the value how many times if you want,
//But if you again to create one name variable it will complain and xcode become unhappy
//once you made the let property then you cannot change it.
var name = "Ranjith"
let age = 30
//age = 31 //Not Possible
//var name = "Kumar" //Not Possible
//let age = 31 //Not Possible

//Types of Data

//type inference
//Swift has capablity to indentify the data type which is going to hold the data
//like
var namee = "Kumar" //String
var agee = 30 //Int

//name = 3.141 //This is Not Possible because we are trying to assign double value into String. Swift Language is enforcing us to follow the type safety

//And while comparing the Float vs Double. Apple recommends to go with Double. because it has higher precesion. like latitude and longitude we can go with double
var latitude = 36.17272457890
var lat:Float = 36.1727245678 //Output says less precesion.

//Operators

var a = 5
var b = 6

var c = a + b

a += 10
a *= 2
a /= 2
a %= 2


//String interpolation

"Your name is \(name) and age is \(age) and after 30 years your age will be \(age * 2)"

//Arrays

let devs = ["ranjith","jobs"]
devs.first
devs[0]

devs + ["Mark"]

//Dictionaries

var devss = ["name": "Ranjith", "age" : "30", "place": "WhiteField"]

devss["name"]
devss["age"]

var anotherValue = ["motherTonge": "Tamil"]

//Conditional statements

if !name.isEmpty && age > 18 {
    print("\(name) is eligble to cast vote this year")
}

//Loops

for i in 1...10 {
    print("\(i) * \(i) = \(i * i)")
}

var i = 2
repeat {
    print("Hey it works")
    i = 1
} while( i > 1)

//Switch case

switch name {
case "Ranjith":
    print("\(name) matched")
fallthrough //Just it will excute the next case statements too when adding fallthrough keyword
case "Kumar":
    print("\(name) matched")
default:
    print("It does not match")
}
