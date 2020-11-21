//
//  ContentView.swift
//  Day-88
//
//  Created by Ranjit on 21/11/20.
//

import SwiftUI

//Day-88
//1)Designing a single card view
//2)Building a stack of cards
//3)Moving views with DragGesture and offset()

extension View {
    
    func stacked(at position: Int, in total: Int) -> some View {
         let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}

struct ContentView: View {
    @State private var cards = [Card](repeating: Card.example, count: 10 )
    var body: some View {
//        CardView(card: Card.example)
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack {
                    ForEach(0..<cards.count, id: \.self) {  index in
                        CardView(card: self.cards[index]) {
                            withAnimation {
                                self.removeCard(at: index)
                            }
                        }
                            .stacked(at: index, in: self.cards.count)
                    }
                }
            }
        }
    }
    
    func removeCard(at index: Int) {
        cards.remove(at: index)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
