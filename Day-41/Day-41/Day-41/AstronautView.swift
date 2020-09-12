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
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("Astronauts.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
