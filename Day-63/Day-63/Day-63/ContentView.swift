//
//  ContentView.swift
//  Day-63
//
//  Created by Ranjit on 14/10/20.
//

import SwiftUI

//Day-63
//1)Integrating Core Image with SwiftUI
//2)Wrapping a UIViewController in a SwiftUI view

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    
    var body: some View {
      /* 1) VStack {
            image?
                .resizable()
                .scaledToFit()
        }.onAppear(perform: loadImage)
 */
        /* 2)*/
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker()
        }
        
    }
    
    func loadImage() {
        guard let inputImage = UIImage(named: "Example") else {
            return
        }
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
//        let currentFilter = CIFilter.sepiaTone()
//        let currentFilter = CIFilter.pixellate()
        guard let currentFilter = CIFilter(name: "CITwirlDistortion") else { return }
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter.setValue(2000, forKey: kCIInputRadiusKey)
        currentFilter.setValue(CIVector(x: inputImage.size.width/2, y: inputImage.size.height/2), forKey: kCIInputCenterKey)
//        currentFilter.inputImage = beginImage
//        currentFilter.intensity = 1
//        currentFilter.scale = 100
        
        guard let outputImage = currentFilter.outputImage else {
            return
        }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
