//Learning Resource : https://www.hackingwithswift.com/100/swiftui
//Learner: @ranmyfriend
//Date: August 9.2020
//Subject: Swift
//Day - 8
//Structs, part one

import Foundation

//Creating your own structs

struct Sport {
    var name: String
}

var cricket = Sport(name: "Cricket")

print(cricket)

cricket.name = "Tennis"

//What’s the difference between a struct and a tuple?
//Tuple vs Struct
//Generally the tuple is same almost like struct. But when you are adding new properties then it will be hard and also passing to the function will hard to read.

struct User {
    var name: String
    var age: Int
    var city: String
}

//Tuple Ex:
func authenticate(_ user: (name: String, age: Int, city: String)) {  }
func showProfile(for user: (name: String, age: Int, city: String)) {  }
func signOut(_ user: (name: String, age: Int, city: String)) {  }

//Struct Ex:
func authenticate(_ user: User) {  }
func showProfile(for user: User) {  }
func signOut(_ user: User) { }


//Computed properties
struct Sport1 {
    let name: String
    let isOlympicSport: Bool //Stored Propety
    
    var olympicStatus: String { //Computed Property
        if isOlympicSport {
            return "\(name) is Olympic Sport"
        } else {
            return "\(name) is not Olympic Sport"
        }
    }
}

let sport1 = Sport1(name: "Footbal", isOlympicSport: true)
print(sport1.olympicStatus)

//Property observers

struct Progress {
    let task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% completed")
        }
    }
}

var progress = Progress(task: "Loading Data", amount: 50)
progress.amount = 50
progress.amount = 60
progress.amount = 90

//Methods

struct City {
    var people: Int
    func calculateTaxes() -> Int {
        people * 1_000
    }
}

let city = City(people: 9_00_000)
print(city.calculateTaxes())


//Properties and methods of strings

let testString = "A for Apple"
print(testString.count)
print(testString.uppercased())
print(testString.hasPrefix("A"))
print(testString.sorted())

//Properties and methods of arrays

var toys = ["Micky"]

toys.append("Mouse")
toys.sorted()
toys.firstIndex(of: "Mouse")

//count == 0 vs isEmpty() Here isEmpty is always the Winner. and so fast
//using isEmpty can return true or false after one simple check: does the start index of my string equal the end index of my string => O(1)
//the count of a string is an O(n) operation: if you have an empty string it’s basically instant,

