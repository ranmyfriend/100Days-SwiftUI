//
//  ContentView.swift
//  Day-46
//
//  Created by Ranjit on 23/09/20.
//

import SwiftUI

//Day - 46
//Challenge Project

struct Arrow: Shape {
    var lineWidth: CGFloat
    
    var animatableData: CGFloat {
        get {
            lineWidth
        }
        set {
            lineWidth = newValue
        }
    }
    
    //Todo: Remove hard coded frame setup and use rect
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 150, y: 300))
        path.addLine(to: CGPoint(x: 150, y: 50))
        path.addLine(to: CGPoint(x: 50, y: 100))
        path.move(to: CGPoint(x: 150, y: 50))
        path.addLine(to: CGPoint(x: 250, y: 100))
        return path
    }
}

struct ContentView_1: View {
    @State private var lineWidth: CGFloat = 2.0
    var body: some View {
        NavigationView {
            VStack {
                Arrow(lineWidth: lineWidth)
                    .stroke(Color.blue, lineWidth: CGFloat(lineWidth))
                    
                Slider(value: $lineWidth, in: 2...10)
                    .padding()
                
                
            }
            .navigationBarTitle("Arrow")
        }
    }
}

struct ColorCyclingRectangle: Shape {
    //Todo: Remove hard coded frame setup and use rect
    //Create a Property which is go adjust the position of gradient
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 20, y: 200))
        path.addLine(to: CGPoint(x: 300, y: 200))
        path.addLine(to: CGPoint(x: 300, y: 400))
        path.addLine(to: CGPoint(x: 20, y: 400))
        path.addLine(to: CGPoint(x: 20, y: 200))
        return path
    }
}

struct ContentView_2: View {
    var body: some View {
        VStack {
            ColorCyclingRectangle()
                .fill(LinearGradient(gradient: Gradient(colors:[Color.red, Color.black]), startPoint: .leading, endPoint: .bottom))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_1()
    }
}
