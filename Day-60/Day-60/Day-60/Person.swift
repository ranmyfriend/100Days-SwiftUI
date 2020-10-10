//
//  RootModel.swift
//  Day-60
//
//  Created by Ranjit on 10/10/20.
//

import Foundation

struct Person: Codable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company, email, address, about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}

struct Friend: Codable {
    let id, name: String
}
