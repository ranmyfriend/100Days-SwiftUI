//
//  Student+CoreDataProperties.swift
//  Day-59
//
//  Created by Ranjit on 09/10/20.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var name: String?

}

extension Student : Identifiable {

}
