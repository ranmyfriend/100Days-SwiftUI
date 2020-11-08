//
//  Prospect.swift
//  Day-82
//
//  Created by Ranjit on 06/11/20.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
   fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    init() {
        people = []
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
    }
}
