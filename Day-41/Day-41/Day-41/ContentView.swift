//
//  ContentView.swift
//  Day-41
//
//  Created by Ranjit on 12/09/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

//Day 41
//Project 8 part 3

//Showing mission details with ScrollView and GeometryReader

struct ContentView: View {
    let astronaunts:[Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronaunts)) {
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
