//
//  Wizard+CoreDataProperties.swift
//  Day-57
//
//  Created by Ranjit on 07/10/20.
//
//

import Foundation
import CoreData


extension Wizard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wizard> {
        return NSFetchRequest<Wizard>(entityName: "Wizard")
    }

    @NSManaged public var name: String?

}

extension Wizard : Identifiable {

}
