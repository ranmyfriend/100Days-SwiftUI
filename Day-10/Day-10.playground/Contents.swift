//Learning Resource : https://www.hackingwithswift.com/100/swiftui
//Learner: @ranmyfriend
//Date: August 10.2020
//Subject: Swift
//Day -10
//Classes & Inheritance

import UIKit

//Creating your own class
//Class are never come with memeber wise initialiser

class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

let dog = Dog(name: "Puppy", breed: "Poodle")
print(dog)

//5 Important things when comparing with STRUCT
/*Classes do not come with synthesized memberwise initializers.
One class can be built upon (“inherit from”) another class, gaining its properties and methods.
Copies of structs are always unique, whereas copies of classes actually point to the same shared data.
Classes have deinitializers, which are methods that are called when an instance of the class is destroyed, but structs do not.
Variable properties in constant classes can be modified freely, but variable properties in constant structs cannot.*/

//Class inheritance

class Poodle: Dog {
    override init(name: String, breed: String) {
        super.init(name: name, breed: "Poodle")
    }
}

//Why don’t Swift classes have a memberwise initializer?
//Because of Inheritance Swift does not give default memberwise initializer to the class. However if you are inheriting from different class based on your customisation, you can write your own initialiser by hand.

//Overriding Methods

class Dog1 {
    func makeNoise() {
        print("Whoop!")
    }
}

class Poodle1: Dog1 {
    override func makeNoise() {
        print("Yip")
    }
}

let poodle1 = Poodle1()
poodle1.makeNoise()

//Final classes

final class ABCD { //cannot inherit this class.
    
}

//Copying objects

class Person {
    var name: String
    init(name: String) {
        self.name = name
    }
}

var person = Person(name: "Steve")

var personCopy = person

personCopy.name = "Jobs"

print(person.name) //Here person and personCopy objects will get reflected if you change the value one of the other.

//Deinitializers

class Person1 {
    var name: String
    init(name: String) {
        self.name = name
    }
    
    func sayGreeting() {
        print("Hello \(name)")
    }
    
    deinit {
        print("\(name) is no more!")
    }
    
}

for _ in 0...3 {
    let p = Person1(name: "John")
    p.sayGreeting()
}

//Why do classes have deinitializers and structs don’t?
//Because class have some set of behaviour called copying. And also who ever gets copy the reference count will be managed by ARC. Here we want to get to know once it looses the all ownership. but in Struct there is no such behaviour, and also it does not require much about this.

//Mutability

class Singer {
    var name: String = "Sid"
}

let singer = Singer()
singer.name = "Pradeep" //Even the singer object is constant but we will be able to change the value. but if you are going with struct, then we have to with var or mutating kind of concept.
