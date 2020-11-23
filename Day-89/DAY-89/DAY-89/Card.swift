//
//  Card.swift
//  Day-88
//
//  Created by Ranjit on 21/11/20.
//

import Foundation

struct Card {
    let prompt: String
    var answer: String
    
    static var example: Card {
        Card(prompt: "Who played the 13th Doctor in Doctor who?", answer: "Jodie Whittaker")
    }
}
