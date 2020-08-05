//Learning Resource : https://www.hackingwithswift.com/100/swiftui
//Learner: @ranmyfriend
//Date: August 5.2020
//Subject: Swift
//Day - 4
//Loops

import Foundation

//For Loops
//for loops are generally used with finite sequences

let n = 1...10 //Closed Range

for num in n {
    print("Num:\(num)")
}

let devs = ["ranjith","subha","boomi"]
for dev in devs {
    print("\(dev) working as iOS Developer")
}

print("----")

//While loops
//On the other hand, while loops can loop until any arbitrary condition becomes false

var number = 1

while number <= 20 {
    print("\(number)")
    number += 1
}

print("Read or not?")

//Repeat Loops
//Statements exectue first and then it will check the condition
//When should you use a repeat loop?
//Basically you want to execute some set of codes or functions which has base case to fail. ==Recursion==
repeat {
    print("Its false")
} while(false)

var numb = 1
repeat {
    print("numb:\(numb)")
    numb += 1
} while(numb <= 20)

//like
let numbers = [1,2,3,4,5]
var random = [Int]()

repeat {
    random = numbers.shuffled()
}while(numbers == random)

print("Numbers & Random has Passed the checks")

//Exiting Loops
//If you want to exit the loop you can go ahead of using break stmt

var numbe = 1
while numbe <= 20 {
    print("numbe:\(numbe)")
    if numbe == 4 {
        break
    }
    numbe += 1
}

//Exiting Multiple Loops

outerLoop: for i in 1...10 {
    for j in 1...10 {
        if(i * j == 50) {
            print("Its enough!!!")
            break outerLoop
        }
        print("product of \(i) * \(j) = \(i * j)")
    }
}

//Skipping Items
//Skipping in the loop we can go with help of  "Continue" keyword

for i in 1...10 {
    if i % 2 == 1 {
        continue
    }
    print(i)
}

//Infinite Loops
var counter = 1
while true {
    print(counter)
    if counter == 273 {
        break
    }
    counter += 1
 }
