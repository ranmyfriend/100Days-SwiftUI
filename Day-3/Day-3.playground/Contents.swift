//Learning Resource : https://www.hackingwithswift.com/100/swiftui
//Learner: @ranmyfriend
//Date: August 4.2020
//Subject: Swift
//Day - 3
//Operators and conditions

import Foundation

//Arithmetic Operators
//Here +,-,/,* operators we can use basically and swift has much more

let firstNum = 5
let secondNum = 1
let res = firstNum - secondNum

//Why can’t Swift add a Double to an Int?
//Because differnt data types has differnt ranges and so we cannot always go one single data type.

let value: Double = 90000000000000001 //This will convert as 90000000000000000 because of the double limitation. But the same

let value1: Int = 90000000000000001 //But here the same value you can go with Int. because it has higher pricision when it compares to Double.

let number = 465
let isMultiple = number.isMultiple(of: 7) //Here isMultiple predefined function they kept it on Math framework

//Operator Overloading

let one = 1
let two = 2

let three = one + two

let firstArray = ["Ranjith", "Kumar"]

let secondArray = ["Jobs"]

let thirdArray = firstArray + secondArray

//let t = one + secondArray //Swift is strongly typed language. You cannot mix up the different data types in computation. same set of data type whatever you can apply operators.

//let a = false + false //Invalid. You cannot perform addition on booleans

//var result = 3 ** 8 //** is not a Built in operator. but if you define it for your own purpose then it will work.

//Compound Assignment Operators
//This helps developer do typing less

var score = 95

score -= 5

var fullname = "Ranjith"

fullname += " Kumar"

//Comparison Operators

"Taylor" < "Swift"

"abc" <= "abcd"

1 == 2

//in Swift 5.3 comparable protocol on Enum
/*enum Sizes: Comparable {
    static func < (lhs: Sizes, rhs: Sizes) -> Bool {
        
    }
    
    case small
    case medium
    case large
}

let first = Sizes.small
let second = Sizes.medium

print(first < second)
*/

//Conditions

let a = 1
let b = 2
if a == b {
    print("Yeah if condition passed")
} else {
    print("else condition passed")
}

//Combining Conditions
// && and || AND and OR operators

let age1 = 12
let age2 = 21

if age1 > 18 && age2 > 18 {
    print("Both are over 18")
}

if age1 > 18 || age2 > 18 {
    print("At least one is over 18")
}

//Ternary Operators
//? :

print(1 == 1 ? "Both are same" : "Not same")

//Switch Statements
//If you have lot of if else conditions then you can go with switch statements and it will make you more readable one

let name = "ranjith"
switch name {
case "ranjith":
    print("ranjith is iOS dev")
    fallthrough //this keyword will consider next case with matching the case also. blindly wants to execute the next case. Usually will go with default one. like dev kind of text we want to add as suffix for name value.
//    You can use fallthrough as many times as you want.
//    Code from the following case will be run if you use fallthrough.
case "kumar":
    print("kumar is Android dev")
case "subha":
    print("subha is Reactive Native dev")
default:
    print("No devs matched :(")
}

var age = 18
switch age {
case 0...8:
    fallthrough
case 9..<18:
    print("You're still a minor")
default:
    print("You're an adult")
}


//Range Operators
//Two ways we can make range operators
//1)..< //Upto range
//2)... //it include the range too
//It works great at using it in Switch statements

let range1 = 49

switch range1 {
case 0..<50:
    print("You studied fair")
case 50...80:
    print("You studied good")
default:
    print("You studied great. Aweful")
}

















