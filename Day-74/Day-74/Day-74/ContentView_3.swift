//
//  ContentView_3.swift
//  Day-74
//
//  Created by Ranjit on 28/10/20.
//

import SwiftUI

struct ContentView_3: View {
    @State private var estimate = 25.0
    var body: some View {
        Slider(value: $estimate, in: 0...50)
            .padding()
            .accessibility(value: Text("\(Int(estimate))"))
    }
}

struct ContentView_3_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_3()
    }
}
