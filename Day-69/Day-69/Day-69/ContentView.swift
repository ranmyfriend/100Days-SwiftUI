//
//  ContentView.swift
//  Day-69
//
//  Created by Ranjit on 21/10/20.
//

import SwiftUI
import LocalAuthentication

//Day-69
//1)Integrating MapKit with SwiftUI
//2)Communicating with a MapKit coordinator
//3)Using Touch ID and Face ID with SwiftUI

struct ContentView: View {
    
    var body: some View {
        //Xcode does not do great job at previewing the map on preview
        MapView()
            .edgesIgnoringSafeArea(.all)
    }
    
}

struct ContentView2: View {
    @State private var isUnlocked: Bool = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, authenticationError) in
                DispatchQueue.main.async {
                    if success {
                        //authenticated successfully
                        self.isUnlocked = true
                    } else {
                        //there was a problem
                    }
                }
            }
        } else {
            //no biometrics
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
