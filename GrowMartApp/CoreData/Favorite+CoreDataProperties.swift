//
//  Favorite+CoreDataProperties.swift
//  
//
//  Created by Kaue de Assis Jacyntho on 04/11/22.
//
//

import Foundation
import CoreData

extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var identifier: String?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var price: String?

}
