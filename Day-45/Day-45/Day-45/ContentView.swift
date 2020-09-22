//
//  ContentView.swift
//  Day-45
//
//  Created by Ranjit on 22/09/20.
//

import SwiftUI

//Day - 45
//Special effects in SwiftUI: blurs, blending, and more
struct ContentView_1: View {
   /*1)
     var body: some View {
        ZStack {
            Image("PH")
            
            Rectangle()
                .fill(Color.red)
                .blendMode(.multiply) //Blend modes allow us to control the way one view is rendered on top of another
        }
        .frame(width: 400, height: 500)
        .clipped()
    }
 */
    
    //2)
    @State private var amount:CGFloat = 0.0
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.red) //Color.red usese SwiftUI Adoptive colors instead of pure read color. but if you want to apply pure red color then go with Color(red: 1, green: 0, blue: 0)
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(Color.green)
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(Color.blue)
                    .frame(width: 200 * amount)
                    .blendMode(.screen)
            }
            .frame(width: 300, height: 300)
            
            Image("PH")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .saturation(Double(amount))
                .blur(radius: (1-amount) * 20)
            
            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}


//Animating simple shapes with animatableData

struct Trapezoid: Shape {
    var insetAmount: CGFloat
    
    var animatableData: CGFloat { //this modifier make the animation very smooth. Why it required because of the insetAmount value changes the View change immediately to the according the amount. but this modifier make smoother one
        set {
            insetAmount = newValue
        }
        get {
            insetAmount
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        
        return path
    }
}

struct ContentView_2: View {
    @State private var insetAmount: CGFloat = 50
    
    var body: some View {
        Trapezoid(insetAmount: insetAmount)
            .frame(width: 200, height: 100)
            .onTapGesture(perform: {
                withAnimation {
                    self.insetAmount = CGFloat.random(in: 10...90)
                }
            })
    }
}

//Animating complex shapes with AnimatablePair
//Here more than on animatable property if you want animate it, the AnimatablePair special wrapper we can use it.

struct Checkerboard: Shape {
    var rows: Int
    var columns: Int
    
    public var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(columns))
        }
        set {
            self.rows = Int(newValue.first)
            self.columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSize = rect.height / CGFloat(rows)
        let columnSize = rect.width / CGFloat(columns)
        
        for row in 0..<rows {
            for column in 0..<columns {
                if (rows + column).isMultiple(of: 2) {
                    let startX = columnSize * CGFloat(column)
                    let startY = rowSize * CGFloat(row)
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        return path
    }
}
struct ContentView_3: View {
    @State private var rows = 4
    @State private var columns = 4
    var body: some View {
        Checkerboard(rows: rows, columns: columns).onTapGesture {
            withAnimation(.linear(duration: 3)) {
                self.rows = 8
                self.columns = 16
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_3()
    }
}
