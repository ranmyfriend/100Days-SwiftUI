//
//  ContentView_2.swift
//  Day-74
//
//  Created by Ranjit on 28/10/20.
//

import SwiftUI

struct ContentView_2: View {
    var body: some View {
        /*Image(decorative: "character")
            .accessibility(hidden: true) //this makes completely invisible to the voice over
 */
        VStack {
            Text("Name")
            Text("Ranjith")
        }
       //Way-1 .accessibilityElement(children: .combine) //This says combining the inner views in voice over
        
        //Way-2 here we can customise the respective txt msg to convey in voice over
        .accessibilityElement(children: .ignore) //This can be ignored
        .accessibility(label: Text("Name is Ranjith"))
    }
}

struct ContentView_2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_2()
    }
}
