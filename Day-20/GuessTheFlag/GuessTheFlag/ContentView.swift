//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ranjit on 21/08/20.
//  Copyright © 2020 Ranjit. All rights reserved.
//

import SwiftUI

//Today Main Topics we are discussing below are:
//VStack, Image, Alert

struct ContentView: View {
    var body: some View {
        //Below we cannot send two different textViews. It only accept one view. So thats why the Stack Views are coming here.
        //There are 3 Stack Views. 1)V-Stack 2)H-Stack 3)Z-Stack(best example: Grid or placing some textview on top of the image)
        VStack(alignment: .leading, spacing: 20) { //Spacing parameter helps to give some space in vertically between the text views
            //VStack can have max to 10 children. if you want to more than 10, then you have to go with 'Group'
            //By default the StackView align the contents in Center and however you want to change the alignment. you can do it
            Text("Hello, India!")
            Text("Hello, Srilanka!")
        }
    }
}

//Colors
struct ContentView_Colors: View {
    var body: some View {
        ZStack {
            //Color.red //In SwiftUI Colors are giving us some set of View. and this textview is sitting on top of Color View.
//            Color.red.frame(width: 200, height: 200) //We can customise the color view
            Color.yellow.edgesIgnoringSafeArea(.all) //by default here the safeArea will ignore to apply the yellow color. but if you want you can apply
            Text("Hello World")
        }
    }
}

//Gradients
struct ContentView_Gradients: View {
    var body: some View {
        //LinearGradient(gradient: Gradient(colors: [Color.black,Color.white]), startPoint: .top, endPoint: .bottom) //This gradient will simply take set of colors and apply from point to point.
//        RadialGradient(gradient: Gradient(colors: [.blue,.black]), center: .center, startRadius: 20, endRadius: 200) //This Gradient will apply the colors in based on the center selection from in to out
        AngularGradient(gradient: Gradient(colors: [.blue,.pink,.yellow,.green]), center: .center)
    }
}

//Button & Images & Alert
struct ContentView_ButtonAndImages: View {
    @State private var showingAlert = false
    var body: some View {
        Button(action: {
            print("Button Tapped!")
            self.showingAlert = true
        }, label: { //This is how you can add image and the title in the button using HStack or VStack. if you want to capture any value go ahead and create the @State property.
            HStack(spacing: 20) {
                Image(systemName: "pencil")
                Text("Edit")
            }
        })
            //this is how you can present an alert. You have to create one state property and maintain the state and whenever you want to present an alert, just make the state property as True.
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Title"), message: Text("Alert Message"), dismissButton: .default(Text("OK")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_ButtonAndImages()
    }
}
