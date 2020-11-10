//
//  ContentView.swift
//  Day-83
//
//  Created by Ranjit on 08/11/20.
//

import SwiftUI

//Day-83
//1)Generating and scaling up a QR code
//2)Scanning QR codes with SwiftUI
//3)Adding options with a context menu

//Day-84
//1)Saving and loading data with UserDefaults
//2)Posting notifications to the lock screen

//Day-85
//Challenge
//https://www.hackingwithswift.com/books/ios-swiftui/hot-prospects-wrap-up

struct ContentView: View {
    var prospects = Prospects()
    
    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Everyone")
                }
            
            ProspectsView(filter: .contacted)
                .tabItem {
                    Image(systemName: "checkmark.circle")
                        Text("Contacted")
                }
            
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Image(systemName: "questionmark.diamond")
                    Text("Uncontacted")
                }
            
            MeView()
                .tabItem {
                    Image(systemName: "person.crop.square")
                    Text("Me")
                }
        }
        .environmentObject(prospects)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
