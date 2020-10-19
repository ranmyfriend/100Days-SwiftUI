//
//  ContentView.swift
//  Day-67
//
//  Created by Ranjit on 19/10/20.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

//Day-67
//Day.66 CONTINUES
//CHALLENGE PROJECT

struct Filter {
    let name: String
    let type: CIFilter
}

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    
    let context = CIContext()
    @State private var showingFilterSheet = false
    @State private var processedImage: UIImage?
    @State private var showingAlert = false
    @State private var showingAlertTitle = ""
    @State private var showingAlertMsg = ""
    
    var filters: [Filter] = [
        Filter(name: "Crystallize", type: CIFilter.crystallize()),
        Filter(name: "Edges", type: CIFilter.edges()),
        Filter(name: "Gaussian Blur", type: CIFilter.gaussianBlur()),
        Filter(name: "Pixellate", type: CIFilter.pixellate()),
        Filter(name: "Sepia Tone", type: CIFilter.sepiaTone()),
        Filter(name: "Unsharp Mask", type: CIFilter.unsharpMask()),
        Filter(name: "Vignette", type: CIFilter.vignette())
    ]
    
    var selectedFilterName: String {
        filters.filter({$0.type == currentFilter}).first?.name ?? "Unknown"
    }
    
    var body: some View {
        let intensity = Binding<Double> (
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    //display the image
                    //Note:What Swift is trying to say is it has support for only a small amount of logic inside SwiftUI layouts – we can use if someCondition, but we can’t use if let, for, while, switch, and so on.
                    
                    if let image = image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                HStack {
                    Text("Intensity")
//                    Slider(value: $filterIntensity)
                    Slider(value: intensity) //CUSTOM BINDING.
                }
                .padding(.vertical)
                
                HStack {
                    Button(selectedFilterName) {
                        //Change Fitler
                        self.showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        //Save the picture
                        guard let processedImage = processedImage else {return}
                        let imageSaver = ImageSaver()
                        imageSaver.errorHandler = {
                            self.showingAlert = true
                            self.showingAlertTitle = "Error"
                            self.showingAlertMsg = "Error while saving:\($0.localizedDescription)"
                            print("Oops:\($0.localizedDescription)")
                        }
                        imageSaver.successHandler = {
                            self.showingAlert = true
                            self.showingAlertTitle = "Success"
                            self.showingAlertMsg = "Image saved successfully"
                            print("Success")
                        }
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("InstaFilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Select a Filter"), buttons: [
                    .default(Text(filters[0].name)) {
                        self.setFilter(filters[0].type)
                    },
                    .default(Text(filters[1].name)) {
                        self.setFilter(filters[1].type)
                    },
                    .default(Text(filters[2].name)) {
                        self.setFilter(filters[2].type)
                    },
                    .default(Text(filters[3].name)) {
                        self.setFilter(filters[3].type)
                    },
                    .default(Text(filters[4].name)) {
                        self.setFilter(filters[4].type)
                    },
                    .default(Text(filters[5].name)) {
                        self.setFilter(filters[5].type)
                    },
                    .default(Text(filters[6].name)) {
                        self.setFilter(filters[6].type)
                    },
                    .cancel()
                ])
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(showingAlertTitle), message: Text(showingAlertMsg), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
//        currentFilter.intensity = Float(filterIntensity)
//        currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
