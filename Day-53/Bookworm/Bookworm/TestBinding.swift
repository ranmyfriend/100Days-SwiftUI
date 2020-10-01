//
//  TestBinding.swift
//  Bookworm
//
//  Created by Ranjit on 01/10/20.
//

import SwiftUI

/*
 Notes: Where does the @Binding comes instead of @State, when you are creating a custom component and if you are performing some action then based on that action you want to update something on contentView. Then @Binding requires. if you are using @State then it followin one way binding only. but if you are going with @Binding, then we can use it two way binding.
  
 /it can omit the KVO, Delegates and al. something you want to inform to your parent class from your child. This is the way we can go for it. Here i just observed an bool variable.
 */

struct PushButton: View {
    let title: String
//   @State var isOn: Bool //ONE WAY BINDING
    @Binding var isOn: Bool //TWO WAY BINDING
    
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white:  0.6), Color(white: 0.4)]
    
    var body: some View {
        Button(title) {
            self.isOn.toggle()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct TestBinding: View {
    @State private var rememberMe = false
    var body: some View {
        VStack {
            PushButton(title: "Remember Me", isOn: $rememberMe)
            Text(rememberMe ? "On" : "Off")
        }
    }
}

struct TestBinding_Previews: PreviewProvider {
    static var previews: some View {
        TestBinding()
    }
}
