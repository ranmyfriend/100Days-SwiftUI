//
//  ContentView.swift
//  Day-78
//
//  Created by Ranjit on 03/11/20.
//

import SwiftUI

//Day-78
//Time for MapKit, I have used Author's LocationFetcher helper class to get back the user's current location
//And also given the permission for capturing the photo using ImagePickerController

struct ContentView: View {
    let locationFetcher = LocationFetcher()
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var lastKnownLocation: Bool = false

    var body: some View {
        NavigationView {
            
            VStack {
                HStack {
                    Button("Start Tracking Location") {
                        self.locationFetcher.start()
                    }
                    .padding()
                    
                    Button("Read Location") {
                        if let location = self.locationFetcher.lastKnownLocation {
                            print("Your location is \(location)")
                            self.lastKnownLocation = true
                        } else {
                            print("Your location is unknown")
                            self.lastKnownLocation = false
                        }
                    }
                    .padding()
                }
                
                if self.lastKnownLocation {
                    if let location = self.locationFetcher.lastKnownLocation {
                        Text("Latitude:\(location.latitude)\n Longitude:\(location.longitude)")
                            .padding()
                            .foregroundColor(.blue)
                    }
                }
                Spacer()
                
            }
            .navigationBarTitle("Day-78")
            .navigationBarItems(trailing: Button(action: {
                self.showingImagePicker = true
            }, label: {
                Image(systemName: "plus")
            }))
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadImage() {
        let epoc = Date().addingTimeInterval(NSTimeIntervalSince1970)
        let fileName = getDocumentsDirectory().appendingPathComponent("\(epoc)")
        if let jpegData = self.inputImage?.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: fileName, options: [.atomicWrite, .completeFileProtection])
            print("Image saved successfully!")
            self.showingImagePicker = false
            self.inputImage = nil
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
