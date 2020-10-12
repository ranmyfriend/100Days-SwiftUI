//
//  ActivityIndicator.swift
//  Day-60
//
//  Created by Ranjit on 12/10/20.
//

import SwiftUI

struct ActivityIndicator: View {
    
    @State private var isAnimating: Bool = false
    
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<5) { index in
                Group {
                    Circle()
                        .frame(width: geometry.size.width / 5,
                               height: geometry.size.height / 5)
                        .scaleEffect(getScale(index))
                        .offset(y: (geometry.size.width / 10) - (geometry.size.height / 2))
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
                .animation(Animation
                            .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
                            .repeatForever(autoreverses: false))
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            self.isAnimating = true
        }
    }
    
    func getScale(_ index: Int) -> CGFloat {
        var value: CGFloat!
        if !self.isAnimating {
            value = 1.0 - CGFloat(index) / 5.0
        } else {
            value = 0.2 + CGFloat(index) / 5.0
        }
        return value
    }
}


struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator()
    }
}
