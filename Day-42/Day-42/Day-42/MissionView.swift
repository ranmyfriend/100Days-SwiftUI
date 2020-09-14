//
//  MissionView.swift
//  Day-41
//
//  Created by Ranjit on 12/09/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

/*
 Geometry Reader -> it gives us the size of manage the view
 ScrollView -> it enables the scrollview if the content is higher than this bounds
 StackView -> manage the views in subsequently
 */

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [CrewMember]
    let missions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    
                    Text(self.mission.formattedLaunchDate)
                        .foregroundColor(Color.secondary)
                    
                    Text(self.mission.description)
                    .padding()
                    
                    ForEach(self.astronauts, id:\.role) {
                        crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut, missions: self.missions)) {
                            HStack {
                                Image(
                                    crewMember.astronaut.id).resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule()
                                        .stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    
                                    Text(crewMember.role)
                                        .foregroundColor(Color.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle()) //This is a Modifier for applying our own plaing button instead of SwiftUI style on navigationLink tappable button style. Actually this is Bug from SwiftUI itself. it may fix in the future release
                    }
                    
                    /* Notes:
                     We could have accomplished the same result using Spacer().frame(minHeight: 25), but using Spacer(minLength: 25) has the advantage that if you ever change your stack orientation – if you go from a VStack to a HStack, for example – then it effectively becomes Spacer().frame(minWidth: 25).
                     */
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    init(missions: [Mission], mission: Mission, astronauts: [Astronaut]) {
        self.missions = missions
        self.mission = mission
        
        var matches = [CrewMember]()
        
        if !astronauts.isEmpty {
            
            for memeber in mission.crew {
                if let match = astronauts.first(where: {$0.id == memeber.name}) {
                    matches.append(CrewMember(role: memeber.role, astronaut: match))
                } else {
                    fatalError("Missing Member")
                }
            }
            
        }
        
        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(missions: missions, mission: missions[0], astronauts: astronauts)
    }
}
