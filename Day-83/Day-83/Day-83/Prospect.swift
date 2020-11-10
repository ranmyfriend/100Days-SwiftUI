//
//  Prospect.swift
//  Day-82
//
//  Created by Ranjit on 06/11/20.
//

import SwiftUI

class Prospect: Identifiable, Codable, Comparable {
    static func < (lhs: Prospect, rhs: Prospect) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func == (lhs: Prospect, rhs: Prospect) -> Bool {
        return lhs.name < rhs.name
    }
    
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
   fileprivate(set) var isContacted = false
    
}

class Prospects: ObservableObject {
    
    @Published private(set) var people: [Prospect]
    static let saveKey = "SavedData "
    
    init() {
        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoded
                return
            }
        }
        
        self.people = []
    }
    
   private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            UserDefaults.standard.setValue(encoded, forKey: Self.saveKey)
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
