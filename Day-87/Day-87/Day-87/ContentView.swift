//
//  ContentView.swift
//  Day-87
//
//  Created by Ranjit on 20/11/20.
//

import SwiftUI

//Day-87
//1)Triggering events repeatedly using a timer
//2)How to be notified when your SwiftUI app moves to the background
//3)Supporting specific accessibility needs with SwiftUI

struct ContentView: View {
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    
    var body: some View {
        Text("Hello, world!")
            .onReceive(timer) { time in
                if self.counter == 5 {
                    self.timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }
                
                self.counter += 1
            }
    }
}

struct ContentView_2: View {
    var body: some View {
        Text("Hello World")
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: { _ in
                print("Moving to the background")
            })
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification), perform: { _ in
                print("Moving to the Foreground")
            })
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification), perform: { _ in
                print("User did take the screenshot")
            })
    }
}

struct ContentView_3: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
//    @Environment(\.accessibilityReduceMotion) var reduceMotion
    
//    @State private var scale: CGFloat = 1
    
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    var body: some View {
//        HStack {
//            if differentiateWithoutColor {
//                Image(systemName: "checkmark.circle")
//            }
//
//            Text("Success")
//        }
//        .padding()
//        .background(differentiateWithoutColor ? Color.black : Color.green)
//        .foregroundColor(Color.white)
//        .clipShape(Capsule())
        
        Text("Hello World")
            .padding()
            .background(reduceTransparency ? Color.black : Color.black.opacity(0.5))
            .foregroundColor(Color.white)
            .clipShape(Circle())
//            .scaleEffect(scale)
//            .onTapGesture {
////                if self.reduceMotion {
////                    self.scale *= 1.5
////                } else {
////                    withAnimation {
//                withOptionalAnimation {
//                        self.scale *= 1.5
//                    }
////                }
//            }
    }
}

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
