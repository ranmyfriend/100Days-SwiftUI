//
//  ContentView.swift
//  Day-64
//
//  Created by Ranjit on 15/10/20.
//

import SwiftUI

//Day-64
//1)Using coordinators to manage SwiftUI view controllers
//2)How to save images to the user’s photo library

struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker: Bool = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        NavigationView {
            VStack {
                image?
                    .resizable()
                    .scaledToFit()
                
                Button("Select Image") {
                    self.showingImagePicker = true
                }
            }
            //we are passing the loadImage as selector when dismissing the ImagePicker, then we are updating the user handpicked image
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
            .navigationBarTitle("Day-64")
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
//        UIImageWriteToSavedPhotosAlbum(inputImage, nil, nil, nil)
        //The above one is related to UIKit. so we can move this into seprate swift class and also we can track the status as well as the error on saving
        ImageSaver().writeToPhotoAlbum(image: inputImage)
    }
}

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishingSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save Finished.")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
