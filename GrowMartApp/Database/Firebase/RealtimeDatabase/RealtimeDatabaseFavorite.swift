//
//  RealtimeDatabaseFavorite.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 02/12/22.
//

class RealtimeDatabaseFavorite {
    var identifier: String = ""
    var image: String = ""
    var name: String = ""
    var price: String = ""
    
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
    
    func toDictionary() -> [String: String] {
        [
            "identifier":identifier,
            "image":image,
            "name": name,
            "price": price
        ]
    }
}
