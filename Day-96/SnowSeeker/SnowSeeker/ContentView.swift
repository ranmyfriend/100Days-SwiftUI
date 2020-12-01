//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Ranjit on 01/12/20.
//

import SwiftUI

//Day-96
//1)Working with two side by side views in SwiftUI
//2)Using alert() and sheet() with optionals
//3)Using groups as transparent layout containers

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: Text("New secondary")) {
                Text("Hello, world!")
            }
            .navigationBarTitle("Primary")
            
            Text("Secondary")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
