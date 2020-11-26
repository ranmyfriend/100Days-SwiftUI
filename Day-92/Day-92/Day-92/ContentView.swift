//
//  ContentView.swift
//  Day-92
//
//  Created by Ranjit on 26/11/20.
//

import SwiftUI

//Day-92
//1)How layout works in SwiftUI
//2)Alignment and alignment guides
//3)How to create a custom alignment guide

struct ContentView: View {
    var body: some View {
        Text("Hello, world!") //We can ask what is the size of contentView. The answer is contentView size is equal to body size. no less no big
            //bottom to top this is how calcualte the size. so based on the child only the parent allocates the space
            .padding(20)
            .background(Color.red)
    }
}

struct ContentView_2: View {
    var body: some View {
//        Text("Live Long Text View")
//            .frame(width: 300, height: 300, alignment: .topLeading)
        
        VStack(alignment: .leading) {
//            Text("Live")
//                .alignmentGuide(.leading) { d in
//                d[.trailing]
//            }
//            Text("Text View Holder")
            ForEach(0..<10) { p in
                Text("Number:\(p)").alignmentGuide(.leading) {
                    _ in
                    CGFloat(p) * -10
                }
            }
        }
        .background(Color.red)
        .frame(width: 300, height: 300)
        .background(Color.blue)
    }
}

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    
    static let midAccountName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView_3: View {
    var body: some View {
        HStack(alignment: .midAccountName) {
            VStack {
                Text("@twostraws")
                    .alignmentGuide(.midAccountName) { d in d[VerticalAlignment.center]
                    }
                Image("paul-hudson")
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            
            VStack {
                Text("Full Name")
                Text("How are you")
                Text("How are you ranjith")
                Text("How are you Kumar")
                Text("PAUL HUDSON")
                    .alignmentGuide(.midAccountName) { d in d[VerticalAlignment.center]
                    }
                    .font(.largeTitle)
                Text("How are you Jobs")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
