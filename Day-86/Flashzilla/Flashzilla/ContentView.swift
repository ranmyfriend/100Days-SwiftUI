//
//  ContentView.swift
//  Flashzilla
//
//  Created by Ranjit on 19/11/20.
//

import SwiftUI

//Day-86
//1)How to use gestures in SwiftUI
//2)Making vibrations with UINotificationFeedbackGenerator and Core Haptics
//3)Disabling user interactivity with allowsHitTesting()

struct ContentView: View {
    @State private var currentAmount: Angle = .degrees(0)
    @State private var finalAmount: Angle = .degrees(0)
    
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { (value) in
                self.offset = value.translation
            }
            .onEnded { (_) in
                withAnimation {
                    self.offset = .zero
                    self.isDragging = false
                }
            }
        
        let pressedGesture = LongPressGesture()
            .onEnded { (value) in
                withAnimation {
                    self.isDragging = true
                }
            }
        
        let combined = pressedGesture.sequenced(before: dragGesture)
        
        return Circle()
            .fill(Color.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
        
        /*
        VStack {
            Text("Hello, world!")
                .onTapGesture {
                    print("Tapped") //SwiftUI always gives first priority on its child gesture rather than priority! So, when we are adding VStack on top of this text and giving tap gesture to it. So text tapped will only called instead of its parent. but if you want to change the priority you can use .highPriorityGesture
                }
    //            .scaleEffect(finalAmount + currentAmount)
                .rotationEffect(finalAmount + currentAmount)
                .gesture(
    //                MagnificationGesture()
                    RotationGesture()
                        .onChanged({ (amount) in
    //                        self.currentAmount = amount - 1
                            self.currentAmount = amount
                        })
                        .onEnded { amount in
                            self.finalAmount += self.currentAmount
    //                        self.currentAmount = 0
                            self.currentAmount = .degrees(0)
                        }
                )
    //            .onLongPressGesture(minimumDuration: 2, pressing: { (inProgress) in
    //                print("InProgress: \(inProgress)")
    //            }) {
    //                print("Long pressed")
    //            }
        }
        .simultaneousGesture( //This will print both parent and its child gesture prints
//        .highPriorityGesture( //To change the priority of its child
            TapGesture()
                .onEnded({ (_) in
                    print("VStack Tapped")
                })
        )
 */
    }
}


import CoreHaptics

struct ContentView_2: View {
    @State private var engine: CHHapticEngine?
     
    var body: some View {
        Text("Hello World")
//            .onTapGesture(perform: simpleSuccess)
            .onAppear(perform: prepareHaptics)
            .onTapGesture(perform: complexSuccess)
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }
        
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }
        
        var events = [CHHapticEvent]()
        
//        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
//        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
//        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity,sharpness], relativeTime: 0) //relativeTime => Start immediately
//        events.append(event)
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
}

struct ContentView_3: View {
    var body: some View {
        VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("World")
        }.contentShape(Rectangle()) //contentShape this will fill up the complete things will be a tappable one.
        .onTapGesture {
            print("VStack Tapped")
        }
        
        
        /*ZStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle Tapped")
                }
            
            Circle()
                .fill(Color.red)
                .frame(width: 300, height: 300)
                .contentShape(Rectangle())
                .onTapGesture {
                    print("Circle Tapped")
                }
//                .allowsHitTesting(false)
        }*/
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
