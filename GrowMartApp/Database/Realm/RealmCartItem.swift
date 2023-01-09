//
//  RealmCartItem.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 09/01/23.
//

import RealmSwift

class RealmCartItem: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var identifier: String = ""
    @Persisted var image: String = ""
    @Persisted var name: String = ""
    @Persisted var price: String = ""

    convenience init(identifier: String?,
                     image: String?,
                     name: String?,
                     price: String?) {
           self.init()
           self.identifier = identifier ?? ""
           self.image = image ?? ""
           self.name = name ?? ""
           self.price = price ?? ""
       }
}
