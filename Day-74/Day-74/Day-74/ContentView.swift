//
//  ContentView.swift
//  Day-74
//
//  Created by Ranjit on 28/10/20.
//

import SwiftUI

//Day-74
//1)Identifying views with useful labels
//2)Hiding and grouping accessibility data
//3)Reading the value of controls

struct ContentView: View {
    let pictures = [
           "ales-krivec-15949",
           "galina-n-189483",
           "kevin-horstmann-141705",
           "nicolas-tissot-335096"
       ]
    let lables = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks"
    ]
    @State private var selectedPicture = Int.random(in: 0...3)
    var body: some View {
        Image(pictures[selectedPicture])
            .resizable()
            .scaledToFit()
            .accessibility(label: Text(lables[selectedPicture]))
            .accessibilityAddTraits(.isButton)
            .accessibilityRemoveTraits(.isImage)
            .onTapGesture {
                self.selectedPicture = Int.random(in: 0...3)
            }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
