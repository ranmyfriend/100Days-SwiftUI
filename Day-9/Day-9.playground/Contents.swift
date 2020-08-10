//Learning Resource : https://www.hackingwithswift.com/100/swiftui
//Learner: @ranmyfriend
//Date: August 10.2020
//Subject: Swift
//Day - 9
//Structs, part two

import UIKit

//Initializers
//By default structs get synthesized memberwise initializer, which means that we automatically get an initializer that accepts values for each of the struct properties.
struct User {
    var name: String
    
    init() {
        name = "Anonymous"
        print("Creating User Model")
    }
}

var user = User()
user.name = "Ranjith"

//Referring to the current instance

struct User1 {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

let u = User1(name: "Sonu")
u.name

//Lazy properties

struct FamilyTree {
    init() {
        print("Creating a Family Tree")
    }
}

struct Person {
    var name: String
   lazy var familyTree = FamilyTree()
    init(name: String) {
        self.name = name
    }
}

let p = Person(name: "Super star")

//Static properties and methods

struct Student {
    static var classSize = 0 //This helps us to know how many students are there inside the class
    var name: String
    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}

let edi = Student(name: "Eddy")
let edie = Student(name: "Eddie")
Student.classSize // This static variable tells how many time this model has created. So we can maintain some set of static variable which holds some set of value


//Access control

struct Person1 {
    private var id: Int
    
    init(id: Int) {
        self.id = id
    }
}

let p1 = Person1(id: 100)

//Below code is InAccessible due to the aa property has private control
//struct A {
//    private var aa: String
//}
//
//let a = A()

