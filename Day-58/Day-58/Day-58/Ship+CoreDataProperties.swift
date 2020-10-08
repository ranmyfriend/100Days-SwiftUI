//
//  Ship+CoreDataProperties.swift
//  Day-58
//
//  Created by Ranjit on 08/10/20.
//
//

import Foundation
import CoreData


extension Ship {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ship> {
        return NSFetchRequest<Ship>(entityName: "Ship")
    }

    @NSManaged public var name: String?
    @NSManaged public var universe: String?

}

extension Ship : Identifiable {

}
