//
//  ImagePicker.swift
//  Day-64
//
//  Created by Ranjit on 15/10/20.
//

import SwiftUI

/*
 NOTES: When you are using UIKit controller to present in SwiftUI, but when there is a delegate which is called after being action taken from UIKit scene, then with the help of coordinators we can intimate to the SwiftUI
 */

/*
 STEPS TO USING A UIKIT COMPONENTS ON SWIFTUI
 1)CONFIRM UIKIT PROTOCOL LIKE. UIViewControllerRepresentable to Swift class
 2)IMPLEMENT THE makeUIViewController(KIND'A) FUNCTION
 3)CREATE A NESTED COORDINATOR CLASS WHERE YOU CAN KEEP PARENT SWIFT CLASS INSTANCE TO IT
 4)CONFIRM AND IMPLEMENT THE RESPECTIVE makeUIViewController -> CONTROLLER DELEGATES TO IT
 5)USING BINDING PROPERTY WE CAN EASILY OBSERVE THE THINGS FROM CONTENTVIEW CALSS
 */

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var image: UIImage? //This binding variable will have the selected image from the image picker controller
    @Environment(\.presentationMode) var presentationMode //This presentationMode helps to dismiss the screen once user press the cancel button
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker //This parent variable will hold the image picker instance. whenever we we need to inform something to parent or want to access it from parent. like binding variable, with help of this we can do.
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        //Delegate methods
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            //once we have selected the image we are dismissing the screen!
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        //context.coordinator will give coordinator instance to picker controller
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
}

