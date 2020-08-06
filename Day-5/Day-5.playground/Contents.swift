//Learning Resource : https://www.hackingwithswift.com/100/swiftui
//Learner: @ranmyfriend
//Date: August 6.2020
//Subject: Swift
//Day - 5
//Functions

import Foundation


//Functions
//Easily we can reuse the same code everywhere, and what if we adding additional behaviour to that function, then it automatically starts feeding to the places whereever you have called.

func printHello() {
    let msg = """

Hey MBRDI, I am Ranjith.

Basically am a iOS Developer who strongly blieve himself to crack any set of challenges in iOS Programming.

Thanks for reading!!! Have a Happy Life
"""
    print(msg)
}

printHello()

//Accepting parameters

func square(number: Int) {
    print("squared:\(number * number)")
}

square(number: 4)

//Returning values
//if you want to return more than one value, then go for tuples

func square2(number: Int) -> Int {
    number * number
}

print(square2(number: 4))

//Parameter labels
//Generally swift uses two labels for parameter. one for inside the function and another one for the caller will get know the identity of what we have to pass.

//Here 'to' Label will intimate the caller ->External name
// 'name' will use inside the function ->Internal name
//Note we can use both the places one single label also. just to avoid the unnecessary confusion
func sayHello(to name: String) {
    print("Hello \(name)")
}

sayHello(to: "Murali")

//Omitting parameter labels
//When you should to Omit Parameter label
//Greeting a person would be greet(taylor) rather than greet(person: taylor)
//Buying a product would be buy(toothbrush) rather than buy(item: toothbrush)
//Finding a customer would be find(customer) rather than find(user: customer)

func setAlarm(_ at: Int) {
    print("Yeah Alarm has set at \(at)")
}

setAlarm(5)

//Default Parameters
func greet(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}

greet("Jobs")
greet("Jobs", nicely: false)

//Variadic functions
//This is kind of fancy name of saying, any number of parameters at same type
//print function is variadic function

print("god","is","there")

func square2(numbers: Int...) {
    for num in numbers {
        print("Squared of \(num) & \(num) = \(num * num)")
    }
}

square2(numbers: 1,2,3,4,5,6)

//Writing throwing functions

enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    
    if password == "password" {
        throw PasswordError.obvious
    }
    
    return true
}

do {
    try checkPassword("password")
} catch(let e) {
    print("Error:\(e)")
}

//inout parameters

var name = "Ranjith"

func appendName(name: inout String) {
    name += " Kumar"
}

appendName(name: &name)

print(name)















