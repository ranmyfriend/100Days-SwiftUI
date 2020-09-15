//
//  ContentView.swift
//  Day-43
//
//  Created by Ranjit on 15/09/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

//Day 43
//Project 9 part one
//Here we are going to focus on 'Drawing'

//1.Creating custom paths with SwiftUI

struct ContentView_Topic1: View {
    var body: some View {
        //SwiftUI gives us a dedicated Path type for drawing custom shapes. like 2d drawing custom rectangle or our own shapes
        Path { path in
            /// Begins a new subpath at the specified point.
            path.move(to: CGPoint(x: 200, y: 100))
            ///Appends a straight line segment from the current point to the
            path.addLine(to: CGPoint(x: 100, y: 300))
            path.addLine(to: CGPoint(x: 300, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 100))
            //path.addLine(to: CGPoint(x: 100, y: 300)) //This particular line helps to adjust the top corner
        }
//        .stroke(Color.blue) //This will apply on outline
//            .fill(Color.blue) //This will apply on filling up the entire path
//            .stroke(Color.blue.opacity(0.25), lineWidth: 10) //If i apply line width with 3 addline then you can the top corner the lines are not showing correctly. for this we have draw the first line again.
        //But what if i wanted to remove that extra line. So you can do with adding StrokeStyle
        
            .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round )) //This will full fill rough corners
        
        //Notes: Using rounded corners solves the problem of our rough edges, but it doesn’t solve the problem of fixed coordinates. For that we need to move on from paths and look at something more complex: shapes.
        
    }
}

//Paths vs shapes in SwiftUI
/*
 Notes: Shapes are build using Paths. And Paths are generally creating the lines and draw something. But shapes will be used for how big it is.
 Shapes are views
 
 Difference between the Path and Shape is RE-USABLITY.
*/

struct Traiangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

//struct Arc: Shape {
//InsettableShape is a Protocol and it confirms to Shape.
struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width/2 - insetAmount, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}
 struct ContentView_Topic2: View {
    var body: some View {
    /*    Traiangle()
//            .fill(Color.red)
            .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            .frame(width: 300, height: 300)*/
        Arc(startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 110), clockwise: true)
            .stroke(Color.blue, lineWidth: 10)
            .frame(width: 300, height: 300)
        
    }
}

//Adding strokeBorder() support with InsettableShape
struct ContentView_Topic3: View {
    var body: some View {
//        Circle()
            //.stroke(Color.blue, lineWidth: 20) //When apply line width and draw the circle the half of the border will be shows on the inside the view and half will be cut off. here is the use case to draw the stroke border.
         Arc(startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 110), clockwise: true) //What if i want to use this strokerBorder in our custom shape class. It is not possible in Straight away. Thats why we are going to use InsettableShape //Now we have added InsettableShape to the Arc
            .strokeBorder(Color.blue, lineWidth: 20) //This looks decent
    }}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_Topic1()
    }
}
