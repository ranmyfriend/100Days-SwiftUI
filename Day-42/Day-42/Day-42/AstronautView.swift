//
//  AstronautView.swift
//  Day-41
//
//  Created by Ranjit on 12/09/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missionsFlew: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                    .layoutPriority(1) //Generally the Text and the Image grows as equal to the parentview. So there is a chance to text breaks. because of higher content. Here when we you go with layoutPriority, It will shrink the view based on the content.
                    
                    if !self.missionsFlew.isEmpty {
                        Form {
                            Section(header: Text("Mission Flew")
                                .foregroundColor(Color.blue)
                                .font(.system(.body))) {
                                    List(self.missionsFlew) { mission in
                                        Text("◉  \(mission.displayName)")
                                    }
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        
        var matches: [Mission] = []
        
        for mission in missions {
            for crew in mission.crew {
                if crew.name == astronaut.id {
                    matches.append(mission)
                    break
                }
            }
        }
        self.missionsFlew = matches
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("Astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("Missions.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
