//
//  Candy+CoreDataProperties.swift
//  Day-58
//
//  Created by Ranjit on 08/10/20.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?

}

extension Candy : Identifiable {

    public var wrappedName: String {
        name ?? "Unknown Candy"
    }
}
