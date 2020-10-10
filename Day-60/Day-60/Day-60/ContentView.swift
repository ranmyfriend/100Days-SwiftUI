//
//  ContentView.swift
//  Day-60
//
//  Created by Ranjit on 10/10/20.
//

import SwiftUI

//Day-60

struct ContentView: View {
    var body: some View {
        /*
         Notes: The below code returns both TextView but one is returning with frame modifier and another one returns normal txtview. so both wont match in SwiftUI. if you want to fix it go ahead and apply AnyView. But AnyView always consume the cost.
         without cost consuming is there any alternative way. Yeah. we can go with Group. But Group is limited to max 10 children
         */
//        if Bool.random() {
//           return AnyView(Text("Hello, world!")
//            .frame(width: 200, height: 100))
//        } else {
//            return AnyView(Text("Hello, world"))
//        }
        
        Group {
            if Bool.random() {
                Text("Hello, world!")
                    .frame(width: 200, height: 100)
            } else {
                Text("Hello, world")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
