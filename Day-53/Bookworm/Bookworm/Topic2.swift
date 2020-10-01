//
//  Topic2.swift
//  Bookworm
//
//  Created by Ranjit on 01/10/20.
//

import SwiftUI

//Using size classes with AnyView type erasure

struct Topic2: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    var body: some View {
        if sizeClass == .compact {
            return
                AnyView(VStack { //In IPAD however you go so small, it will compact. So VStack is the nicer one here. because if you go with VStack, then it will work fine in COMPACT & REGULAR. When we changed here as VStack it will give an error. because both the condition it requires the same kind of view. This kind of place where we can introuduce TypeErasure.
                    Text("Active size class:")
                    Text("Compact")
                }
                .font(.largeTitle))
        } else {
            return
                AnyView(HStack {
                Text("Active size class:")
                Text("Regular")
            }
            .font(.largeTitle))
        }
    }
}

struct Topic2_Previews: PreviewProvider {
    static var previews: some View {
        Topic2()
    }
}
