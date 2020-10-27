//
//  ContentView.swift
//  Day-72
//
//  Created by Ranjit on 26/10/20.
//

import SwiftUI
import MapKit
import LocalAuthentication

//Day-72
//1)Making someone else’s class conform to Codable
//2)Locking our UI behind Face ID

struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    @State private var isUnlocked = true
    @State private var alertTitle: String = ""
    @State private var alertMsg: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        ZStack {
            if isUnlocked {
                MyMapView(centerCoordinate: $centerCoordinate, locations: $locations, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, showingEditScreen: $showingEditScreen)
            } else {
                 Button("Unlock places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(Color.white)
                .clipShape(Capsule())
            }
        }
        .alert(isPresented: $showingPlaceDetails) {
            Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information"), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                self.showingEditScreen = true
            })
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(self.alertTitle), message: Text(self.alertMsg), dismissButton: .default(Text("OK")))
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let fileName = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
        
        do {
            let data = try Data(contentsOf: fileName)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            showAlert = true
            alertTitle = "Error"
            alertMsg = "Unable to load saved data."
            print("Unable to load saved data.")
        }
    }
    
    func saveData() {
        do {
            let fileName = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: fileName, options: [.atomicWrite,.completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (sucess, authenticationError) in
                DispatchQueue.main.async {
                    if sucess {
                        self.isUnlocked = true
                    } else {
                        //Error
                    }
                }
            }
        } else {
            //No biometric
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
