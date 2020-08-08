//Learning Resource : https://www.hackingwithswift.com/100/swiftui
//Learner: @ranmyfriend
//Date: August 8.2020
//Subject: Swift
//Day - 7
//Closures, part two

import UIKit

//Using closures as parameters when they accept parameters

func travel(action: (String) -> Void) {
    print("I'm getting ready to go")
    action("London")
    print("I arrived.")
}

travel { (place: String) in
    print("I am going to \(place) in my car")
}

print("=======")
//Using closures as parameters when they return values

func travel1(action: (String) -> String) {
    print("I'm getting ready to go")
    let description = action("london")
    print(description)
    print("I arrived")
}

travel1 { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

//Shorthand parameter names

func travel2(action: (String) -> String) {
    print("I'm getting ready to go")
    let description = action("london")
    print(description)
    print("I arrived")
}

travel2 { "I'm going to \($0) in my car" }

//Closures with multiple parameters
func travel3(action: (String, Int) -> String) {
    print("I'm getting ready to go")
    let description = action("london", 60)
    print(description)
    print("I arrived")
}

travel3 {
    return "I'm going to \($0) in my car \($1) miles per hour"
}

//Returning closures from functions

func travel4() -> (String) -> Void {
    return {
        print("I am going to \($0)")
    }
}

let res = travel4()
res("london")

//Capturing values

func travel5() -> (String) -> Void {
    var counter = 1
    return {
        print("\(counter) I am going to \($0)")
        counter += 1
    }
}

let result = travel5()
result("london")
result("london")
result("london")
result("london")

