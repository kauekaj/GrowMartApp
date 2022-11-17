//
//  CoreDataFavorite+CoreDataProperties.swift
//  
//
//  Created by Kaue de Assis Jacyntho on 17/11/22.
//
//

import Foundation
import CoreData


extension CoreDataFavorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataFavorite> {
        return NSFetchRequest<CoreDataFavorite>(entityName: "CoreDataFavorite")
    }

    @NSManaged public var identifier: String?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var price: String?

}
