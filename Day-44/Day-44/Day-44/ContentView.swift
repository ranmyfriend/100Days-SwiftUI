//
//  ContentView.swift
//  Day-44
//
//  Created by Ranjit on 21/09/20.
//

import SwiftUI

//Day-44
//Transforming shapes using CGAffineTransform and even-odd fills

//CGAffineTransform it helps to rotate the path, or scaled and sheard
//3.141 radian equal to 180 degree

struct Flower: Shape {
    var petalOffset: Double = -20
    var petalWidth: Double = 100
    
   /* How we are creating a Flower using following steps

    /Create a new empty path.
    /Count from 0 up to pi multiplied by 2 (360 degrees in radians), counting in one eighth of pi each time – this will give us 16 petals.
    /Create a rotation transform equal to the current number.
    /Add to that rotation a movement equal to half the width and height of our draw space, so each petal is centered in our shape.
    /Create a new path for a petal, equal to an ellipse of a specific size.
    /Apply our transform to that ellipse so it’s moved into position.
    /Add that petal’s path to our main path.
 */
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        //Stride function helps to go from 0 to CGFloat.pi * 2 but it will generate GFloat.pi / 8 according to range.
        for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
            let rotation = CGAffineTransform(rotationAngle: number)
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width/2, y: rect.height/2))
            
            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width/2))
            let rotatedPetal = originalPetal.applying(position)
            
            path.addPath(rotatedPetal)
        }
        return path
    }
}
struct ContentView_Topic_1: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    
    var body: some View {
        VStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                .fill(Color.red, style: FillStyle(eoFill: true))
//                .fill(Color.red)
//                .stroke(Color.red, lineWidth: 1.0)
            
            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal, .bottom])
            
            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
        }
    }
}


//Creative borders and fills using ImagePaint
struct ContentView_Topic_2: View {
    var body: some View {
        Text("Hello World")
            .frame(width: 200, height: 200)
//            .background(Color.red)
//            .border(Color.red, width: 20)
//        background(Image("Example")) //This is how can we set background image to the textview. but what if we want to set the border color using image. here we cannot set border color using image. Thats why apple introduced 'ImagePaint'
//            .border(ImagePaint(image: "Example", scale: 0.2), width: 30)
        
    }
}

//Enabling high-performance Metal rendering with drawingGroup()
//SwiftUI uses Core Animation by default. but here if rendering goes to below 60 fps will have the problem. but most of the iphones are having 120fps

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: CGFloat(value))
//                    .strokeBorder(
//                        self.color(
//                            for: value,
//                            brightness: 1.0),
//                            lineWidth:2
//                    )
                    .stroke(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1.0),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: .top, endPoint: .bottom)) //by appling with 100 lineGrdient in slider. you will see the performance lag. here we can solve it with help of drawingGroup(This is powered by Metal - Apple's framework)
            }
            .drawingGroup() //Game Changer line : So fast and when you face actual performance problems try to use it.
        }
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value)/Double(self.steps) + self.amount
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}
//It performed by core animation and drawn 100 cycle animations
struct ContentView_Topic_3: View {
    @State private var colorCycle = 0.0
    var body: some View {
        VStack {
            ColorCyclingCircle(amount: self.colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_Topic_3()
    }
}
