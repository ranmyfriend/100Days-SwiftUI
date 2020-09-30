//
//  Order.swift
//  Day-50
//
//  Created by Ranjit on 28/09/20.
//

import Foundation

class Order: ObservableObject {
    
    @Published var order: info = info()

    struct info: Codable {
        
        static let types = ["Vannila", "Strawberry", "Chocolate", "Rainbow"]
        
        var type = 0
        var quantity = 3
        
        var specialRequestEnabled = false {
            didSet {
                if specialRequestEnabled == false {
                    extraFrosting = false
                    addSprinkles = false
                }
            }
        }
        var extraFrosting = false
        var addSprinkles = false
        
        var name = ""
        var streetAddress = ""
        var city = ""
        var zip = ""
        
        var hasValidAddress: Bool {
            if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
                return false
            }
            return true
        }
        
        var cost: Double {
            var cost = Double(quantity) * 2
            cost += Double(type) / 2
            
            if extraFrosting {
                cost += Double(quantity)
            }
            
            if addSprinkles {
                cost += Double(quantity) / 2
            }
            
            return cost
        }
        
    }
}

/* OLDER WAY
class Order: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case type, quantity, specialRequestEnabled, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    static let types = ["Vannila", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        cost += Double(type) / 2
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
    func encode(to encoder: Encoder) throws {
        var containter = encoder.container(keyedBy: CodingKeys.self)
        
        try containter.encode(type, forKey: .type)
        try containter.encode(quantity, forKey: .quantity)
        try containter.encode(extraFrosting, forKey: .extraFrosting)
        try containter.encode(addSprinkles, forKey: .addSprinkles)
        try containter.encode(name, forKey: .name)
        try containter.encode(streetAddress, forKey: .streetAddress)
        try containter.encode(city, forKey: .city)
        try containter.encode(zip, forKey: .zip)
    }
    
    
}
*/
