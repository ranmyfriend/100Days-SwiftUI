//
//  TaskView.swift
//  Day-77
//
//  Created by Ranjit on 02/11/20.
//

import SwiftUI

//Challenge: https://www.hackingwithswift.com/guide/ios-swiftui/6/3/challenge

struct TaskView: View {
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    var body: some View {
        NavigationView {
            
            Text("Select an Image")
                .font(.headline)
            
            .navigationBarTitle("Challenge")
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
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}
