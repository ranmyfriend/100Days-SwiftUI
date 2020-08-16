//Learning Resource  https://www.hackingwithswift.com/100/swiftui
//Learner: @ranmyfriend
//Date: August 16.2020
//Subject: Swift
//Day - 15

/*Recap of
    - Properties
    - Static properties and methods
    - Access control
    - Polymorphism and typecasting
    - Closures
 */

import Foundation
import PlaygroundSupport

//Properties

struct Person {
    
    static var favoriteSong = "Look What You Made Me Do"
    
    var clothes: String {
        willSet {
            print("I will change \(clothes) and \(shoes)")
        }
        didSet {
            print("I changed \(clothes) and \(shoes)")
        }
    }
    var shoes: String
    
    var description: String {
        "I like wearing \(clothes) & \(shoes)"
    }
    
    init(clothes: String, shoes: String) {
        self.clothes = clothes
        self.shoes = shoes
    }
    
    func describe() {
        print("I like wearing \(clothes) & \(shoes)")
    }
}

var person = Person(clothes: "T-Shirts", shoes: "Nike Shoe")

person.describe()

person.clothes = "Shirts"

person.description

//Static properties and methods
//Shared Properties across the objects. different people have same taste

struct TaylorFan {
    let name: String
    static var favoriteSong = "Look What You Made Me Do"
}

let james = TaylorFan(name: "James")
let anderson = TaylorFan(name: "Anderson")

//Access control
/*Public: this means everyone can read and write the property.
Internal: this means only your Swift code can read and write the property. If you ship your code as a framework for others to use, they won’t be able to read the property.
File Private: this means that only Swift code in the same file as the type can read and write the property.
Private: this is the most restrictive option, and means the property is available only inside methods that belong to the type, or its extensions.*/

//Polymorphism & Type casting

class Album {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func getPerformance() -> String {
        "\(name) Album sold alots"
    }
}

class LiveAlbum: Album {
    var location: String
    
    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        "\(name) Live Album sold alots"
    }
}

class StudioAlbum: Album {
    var studio: String
    
    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        "\(name) Studio Album sold alots"
    }
}

let avmStudio = StudioAlbum(name: "Ilayaraja", studio: "AVM")
let arLive = LiveAlbum(name: "AR", location: "WhiteField")

let allAlbums:[Album] = [avmStudio, arLive]

for album in allAlbums {
    album.getPerformance()
}

//Type casting comes under two formats like (? or !)

for album in allAlbums {
    
    if let studioAlbum = album as? StudioAlbum {
        print(studioAlbum.studio)
    }
    album.getPerformance()
}

//closures

func sendMeSomething(_ handler: @escaping((String)-> Void)) {
    handler("Hello")
}

sendMeSomething() { something in
    print("something is \(something)")
}

