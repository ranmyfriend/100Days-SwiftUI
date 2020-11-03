//
//  ContentView.swift
//  HotProspects
//
//  Created by Ranjit on 03/11/20.
//

import SwiftUI

//Day-79
//1)Reading custom values from the environment with @EnvironmentObject
//2)Creating tabs with TabView and tabItem()

//Wherever the user object name property changes whoever listens at using environment object, then all are getting updated.
class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        TextField("Name", text: $user.name)
    }

}

struct DisplayView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Text(user.name)
    }

}

struct ContentView: View {
    let user = User()
    var body: some View {
        VStack {
            EditView()
            DisplayView()
//            EditView().environmentObject(user)
//            DisplayView().environmentObject(user)
        }.environmentObject(user) //This is how also we can distribute the user(bindable) object to this childrens
    }
}

struct ContentView_2: View {
    @State private var selectedTab = 2
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab1")
                .onTapGesture {
                    self.selectedTab = 1
                }
                .tabItem {
                    Image(systemName: "star")
                    Text("One")
                }
                .tag(0)
            Text("Tab2")
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Two")
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
