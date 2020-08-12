//Learning Resource  https://www.hackingwithswift.com/100/swiftui
//Learner: @ranmyfriend
//Date: August 12.2020
//Subject: Swift
//Day -11
//Protocols & Extensions

import UIKit

//Protocols and the Protocol Oriented Programming helps to solve larger and complex inheritance kind of structure into smaller one. It will enhance the readablity and also esaily we can able to distribute

//Protocols

protocol Identifiable {
    var id: String { get set }
}

struct User: Identifiable {
    var id: String
}

struct Employee: Identifiable {
    var id: String
}

//The below func can be used across the objects who ever confirms to `Identifiable` protocol
func displayId(thing: Identifiable) {
    print("Displaying id: \(thing.id)")
}

let user = User(id: "1234ABC")
let employee = Employee(id: "Emp.1234")
displayId(thing: user)
displayId(thing: employee)

//Protocol Inheritance
//More than one protocol inheriting from other its called. Protocol Inheritance

protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}

protocol Employeee: Payable, NeedsTraining, HasVacation {
    
}

//Extensions

extension Int {
    func squared() -> Int {
        return self * self
    }
}

let number = 8
number.squared()

//Protocol extensions

let employees = ["Ranjith","Subhashini","Boominadha"]

extension Collection {
    func summarize() {
        print("Employees Are:\n")
        for name in self {
            print("Employee Name: \(name)")
        }
    }
}

employees.summarize() // How this summarize function we are able to access in the Array, because Array, Set, Dictionary all are structs are confirmed to Collection Protocol. and if are writing any set of methods inside the collection extension, then we will be able to access it from Array or set or dictionaries

//Protocol-oriented programming
//Here we are giving default implementation to the protocol methods, which is served elgantly to the Model Objects who ever confirms.
//There is no difference beween POP and OOPS. POP heavily dependent on protocols and OOPS heavily dependent on classes. thats it.
protocol Identifiable1 {
    var id: String { get set }
    func identify()
}

extension Identifiable1 {
    func identify() {
        print("Id is:\(id)")
    }
}

struct Person: Identifiable1 {
    var id: String
}

let person = Person(id: "ranmyfriend")

person.identify()

