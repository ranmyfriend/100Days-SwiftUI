//Learning Resource  https://www.hackingwithswift.com/100/swiftui
//Learner: @ranmyfriend
//Date: August 15.2020
//Subject: Swift
//Day - 14
//Recap of
/*  - Functions
    - Optionals
    - Optional chaining
    - Enumerations
    - Structs
    - Classes
*/

import Foundation

//Functions

func sayHello(to person:String) {
    print("Hello \(person)")
}

sayHello(to: "Jobs")

//Optionals

var name: String? = nil

name = "Ranjith"

if let name = name {
    print("\(name)")
}

//Optional chaining

var alphabets = ["a","b","c"]

alphabets.first?.uppercased()

//Nil coalescing operator

var nameee = name ?? "unknown"

//Enumerations

enum WheatherType {
    case sun
    case wind(speed: Int)
}

let wind = WheatherType.wind(speed: 10)
let sunny = WheatherType.sun

switch wind {
case .sun:
    print("It is too hot")
case .wind(let speed) where speed > 5:
    print("its wind and speed:\(speed)")
default:
    print("Not matched")
}

//Structs

struct Person {
    var name: String
    func getName() -> String {
        return name
    }
}

let person = Person(name: "Sun")
print(person.getName())

//Classes

class Basic {
    var name: String
    init(name: String) {
        self.name = name
    }
    func printName() {
        print("Name = \(name)")
    }
}

class Advanced: Basic {
    
}

let advanced = Advanced(name: "Advanced")

advanced.printName()
