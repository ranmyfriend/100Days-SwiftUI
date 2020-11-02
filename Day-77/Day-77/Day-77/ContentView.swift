//
//  ContentView.swift
//  Day-77
//
//  Created by Ranjit on 02/11/20.
//

import SwiftUI

//Day-77
//Is Swift supporting operator overloading? The Answer is YES. it is supporting with help of customising or overriding the existing operator

extension Int {
    //by default swift does not allow this operation. So you cannot mulitply the integer with CGFloat. So for this reason we have overrided the * operator.
    //But you should obey the parameter while passing. like lhs should be an Integer. if you are trying to pass an CGFloat or some other data types then it will give you an error.
    //Instead of Int on lhs dataType. you can say `Self` => Swift automatically determines the type
    static func * (lhs: Int, rhs: CGFloat) -> CGFloat {
        return CGFloat(lhs) * rhs
    }
}

//BinaryInteger this is the superior protocol which allows to do the same computation on Int16, Int8, Int32, Int64.
//If you are dealing with CoreData or Sockets related stuff then we can go with BinaryInteger is more useful
extension BinaryInteger {
    static func * (lhs: Self, rhs: CGFloat) -> CGFloat {
        return CGFloat(lhs) * rhs
    }

    static func * (lhs: CGFloat, rhs: Self) -> CGFloat {
        return lhs * CGFloat(rhs)
    }

    static func * (lhs: Self, rhs: Double) -> Double {
        return Double(lhs) * rhs
    }

    static func * (lhs: Double, rhs: Self) -> Double {
        return lhs * Double(rhs)
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
    
    func computeIntWithCGFloat() {
        let a = 3 * CGFloat(4.5)
        print("ans: \(a)")
        
        let b = Int32(4) * CGFloat(6.5)
        let b1 = UInt32(4) * CGFloat(6.5)
        
        var example = NonNegative(wrappedValue: 5)
        example.wrappedValue -= 10
        print(example.wrappedValue)
    }
}

struct User {
    @NonNegative var score = 0 //This is kind of nonNegative wrapper type of variable we can create.
    
    func hey() {
        let a = score * CGFloat(4.0) //Here indirectly we are feeding the overriding property behavior to this variable.
    }
}

@propertyWrapper
struct NonNegative<Value: BinaryInteger> {
    var value: Value

    init(wrappedValue: Value) {
        if wrappedValue < 0 {
            self.value = 0
        } else {
            self.value = wrappedValue
        }
    }

    var wrappedValue: Value {
        get { value }
        set {
            if newValue < 0 {
                value = 0
            } else {
                value = newValue
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
