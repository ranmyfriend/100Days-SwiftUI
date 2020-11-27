//
//  ContentView.swift
//  Day-93
//
//  Created by Ranjit on 27/11/20.
//

import SwiftUI

//Day-93
//1)Absolute positioning for SwiftUI views
//2)Understanding frames and coordinates inside GeometryReader
//3)ScrollView effects using GeometryReader


/*
 To understand what’s happening here you need to remember the three step layout process of SwiftUI:

 A parent view proposes a size for its child.
 Based on that information, the child then chooses its own size and the parent must respect that choice.
 The parent then positions the child in its coordinate space.
 */

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .offset(x: 100, y: 100) //this offset denotes takes the distance from the other view
//            .position(x: 100, y: 100) //This is position modifier to fix the textview on (x,y)
            .background(Color.red)
            
    }
}

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(Color.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { geo in
                Text("Center")
                    .background(Color.blue)
                    .onTapGesture {
                        print("Global center:\(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        print("Custom center:\(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                        print("Local center:\(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                    }
            }
            .background(Color.orange)
            Text("Right")
        }
    }
}


struct ContentView_2: View {
    var body: some View {
        OuterView()
            .background(Color.red)
            .coordinateSpace(name: "Custom")
        
        
//        VStack {
//            GeometryReader { geo in
//                Text("Hello World")
//                    .frame(width: geo.size.width * 0.9)
//                    .background(Color.red)
//            }
//            .background(Color.green)
//
//            Text("More Text")
//                .background(Color.blue)
//        }
        
    }
}

struct ContentView_3: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
//    var body: some View {
//        GeometryReader { fullView in
//            ScrollView(.vertical) {
//                ForEach(0..<50) { index in
//                    GeometryReader { geo in
//                        Text("Row #\(index)")
//                            .font(.title)
//                            .frame(width: fullView.size.width)
//                            .background(self.colors[index % 7])
//                            .rotation3DEffect(
//                                .degrees(Double(geo.frame(in: .global).minY - fullView.size.height / 2) / 5),
//                                axis: (x: 0, y: 1, z: 0))
//                    }
//                    .frame(height: 40)
//                }
//            }
//        }
//    }
    
    var body: some View {
            GeometryReader { fullView in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<50) { index in
                            GeometryReader { geo in
                                Rectangle()
                                    .fill(self.colors[index % 7])
                                    .frame(height: 150)
                                    .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                            }
                            .frame(width: 150)
                        }
                    }
                    .padding(.horizontal, (fullView.size.width - 150) / 2)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
