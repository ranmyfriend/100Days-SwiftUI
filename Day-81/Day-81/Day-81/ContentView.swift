//
//  ContentView.swift
//  Day-81
//
//  Created by Ranjit on 05/11/20.
//

import SwiftUI

//Day-81
//Project 16, part 3
//1)Creating context menus(3rd Touch)
//2)Scheduling local notifications
//3)Adding Swift package dependencies in Xcode

struct ContentView: View {
    @State private var backgroundColor = Color.red
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
                .background(backgroundColor)
            
            Text("Change color")
                .padding()
                //Enabling the 3d Touch using ContextMenu to changing the color of Hello World text
                .contextMenu {
                    Button(action:{
                        self.backgroundColor = .red
                    }) {
                        Text("Red")
                        if backgroundColor == .red {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.red)
                        }
                    }
                    
                    Button(action: {
                        self.backgroundColor = .green
                    }) {
                        Text("Green")
                        if backgroundColor == .green {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                    
                    Button(action: {
                        self.backgroundColor = .blue
                    }) {
                        Text("Blue")
                        if backgroundColor == .blue {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                }
        }
    }
}

import UserNotifications
//Adding some Local Notification
struct ContentView_2: View {
    var body: some View {
        VStack {
            Button(action: {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
                    if success {
                        print("All set")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }, label: {
                Text("Request Permission")
            })
            
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the boy"
                content.subtitle = "he looks hungry!"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
                
            }
        }
    }
}

import SamplePackage
struct ContentView_3: View {
    let possibleNumbers = Array(1...60)
    
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
    var body: some View {
        Text(results)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
