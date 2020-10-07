//
//  Movie+CoreDataProperties.swift
//  Day-57
//
//  Created by Ranjit on 07/10/20.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    //Either you can go with optional and going with seprated custom getter property to return non-optional value of title
    //or you can simply make the title as non optional straight away it will work seamlessly
    @NSManaged public var title: String
    @NSManaged public var director: String
    @NSManaged public var year: Int16

}

extension Movie : Identifiable {

}
