//Learning Resource : https://www.hackingwithswift.com/100/swiftui
//Learner: @ranmyfriend
//Date: August 3.2020
//Subject: Swift
//Day - 2

import Foundation

//Array
let ranjith = "Ranjith Kumar"
let subha = "Subhashini Narayanaswamy"
let boominadha = "Boominadha Prakash"

let iOSDevelopers = [ranjith, subha, boominadha] //This is a Collection of values
let iOSDevs:[String] = [ranjith, subha, boominadha] //Here you can use Type Annoatations
//Same goes for [Bool], [Int], [Double] and etc.

//If you want to access it, simply you can go with help of index based.
iOSDevelopers[1]
//iOSDevelopers[9] //This will give an error. because of out of index.

//Sets
//Sets are like a Arrays but two things make this is so different from an Array
//1)different order
//2)no duplicates

let nums = Set(["One", "Two", "Three"]) //Check the output prints in different order. that decided by Swift

let numss = Set(["One", "Two", "One"]) //Here this output wont prints 'two times of One'. because it neglects the duplicates

//Tuples
//Tuples are like Arrays, But three things make this is so different from an Array
//1)You cannot add or remove from tuples, because they are fixed size
//2)You can’t change the type of items in a tuple; they always have the same types they were created with.
//3)You can access items in a tuple using numerical positions or by naming them, but Swift won’t let you read numbers or names that don’t exist.

let fullName = (firstName: "Ranjith", lastName: "Kumar")

fullName.0 //by using position we can access the tuple
fullName.firstName //or by using names we can access it

//Arrays vs Sets vs Tuples
//Tuples -> if you need any fixed collection which has precise position or name
    // A user's address. we will easily get to know where city or door no has
//Sets -> if you need collection which should not have any duplicates and order doesn't matters
//Array -> if you need collection which supports duplicates and also orders matters

//Dictionaries
//Dictionaries are like Arrays, But you always access it via key. Here you should know they key 'string' to access the respective value

let heights = ["Ranjith" : 1.56, "Jobs" : 1.5]

heights["Ranjith"]

let planets = [1: "Mercury", 2: "Venus"]
let venus = planets[2, default: "Planet X"] //here if planents does not have 2 key value then it will prints 'Planent X'

//Empty Collections
var teams = [String:String]() //Empty Dictionary //Shorter Syntax
teams["Ranjith"] = "India"
teams["Kumar"] = "India"

var teams1 = Dictionary<String,String>()

var heightsEmpty = [Int]() //Shorter Syntax
var heightsEmpty1 = Array<Int>()

var words = Set<String>()
var numbers = Set<Int>()

//Enumerations
//Enums are defining a group of values which is easier to use

//When you want to do some accidental mistakes also it wont happen when you go with Enums, like

//And when you got a response or not, if we are telling it via Strings or some other datatype, it will create lot of problems. because it is easily changable

let failure = "failed"
let fails = "fails"

//But here developer can change the value in differently and also cross checking may failure in sometimes.
//In order to catch and address it elgantaly we can go with Enum

enum Result {
    case success
    case failure
}

let failuree = Result.failure //That's it. It's unchangeable and also uniquley we can address this for whole application

//Enums Associated Values
//Enums can carry forward with the context what it drives. Like
enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

let activity = Activity.talking(topic: "snooker")


//Enum Raw Values
//So, enums with associated values let us add extra information to an enum case
//Here Swift it consider the first case if you initial any value, the next set of cases automatically incrementing by 1
enum Planets: Int {
    case mercury = 5
    case venus
    case earth
    case mars
}

let earth = Planets(rawValue: 7)

enum Weather {
    case sunny
    case windy(speed: Int)
    case rainy(chance: Int, amount: Int)
}
