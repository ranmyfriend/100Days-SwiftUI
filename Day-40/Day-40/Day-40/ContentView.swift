//
//  ContentView.swift
//  Day-40
//
//  Created by Ranjit on 11/09/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

//Day 40
//Project 8 part 2

struct ContentView: View {
    let astronaunts:[Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: Text("Detail View")) {
                    Image(mission.image)
                        .resizable()
                    .scaledToFit() //Shortcut to aspectRatio
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName).font(.headline)
                        Text(mission.formattedLaunchDate)
                    }
                }
            }
        .navigationBarTitle("Moonshoot")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
