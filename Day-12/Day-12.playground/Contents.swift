//Learning Resource  https://www.hackingwithswift.com/100/swiftui
//Learner: @ranmyfriend
//Date: August 13.2020
//Subject: Swift
//Day - 12
//Optionals

import Foundation

//Optionals
//Handling missing data

var age: Int?
age = 30

//Unwrapping Optionals

var name: String?

//name.count like this we cannot access directly. because name itself a Optional one. and if you want to access count kind of methods or properties which are belongs to the String. then you must have to unwrap it.
//like
if let unwrapped = name {
    print("\(unwrapped.count) Letters")
} else {
    print("Missing name :(")
}

//Unwrapping with Guard

func sayGoodbye(to whom:String?) {
    guard let name = whom else {
        print("You did not provide name")
        return
    }
    print("Goodbye \(name)")
}
sayGoodbye(to: nil) //Onething here is; guard let name property will be accessed after the condition too. its based on the parent scope. not like if let.

//Force unwrapping

var five = 5
var fiveString = String(five)
var fi = Int(fiveString)!

//Implicitly unwrapped optionals
//These dont have safety checks
var namee: String! = nil // We are promising to the compiler, this property wont become nil and also no need to write if let or guard let condition to unwrap this.

//Nil coalescing

var place: String?
place = nil
print("\(place ?? "Unknown")")

//Optional chaining
let devs = ["Jobs","Gates","Mark"]
let jobs = devs.first?.uppercased()

//Optional try

func tellMeSomething() throws -> String? {
    return "hey"
}

if let something = try? tellMeSomething() {
    print("It said:\(something)")
}else {
    print("It did not say anything")
}

//Failable initializers

struct Person {
    var name: String
    init?(name: String) {
        if name.count > 1 {
            self.name = name
        } else {
            return nil
        }
    }
}

let per = Person(name: "a")

//Typecasting

class Animal {}
class Fish: Animal {}
class Dog: Animal {
    func makeNoise() {
        print("WHOOOF")
    }
}

let pets = [Fish(),Dog()]
for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}

//
