//
//  Product.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 07/09/22.
//

public struct Product {
    enum Field: String {
        case name
        case price
        case category
        case size
        case condition
        case brand
        case description
        
        func getFormattedName() -> String {
            switch self {
            case .name:
                return "título"
            case .price:
                return "preço"
            case .category:
                return "categoria"
            case .size:
                return "tamanho"
            case .condition:
                return "condição"
            case .brand:
                return "marca"
            case .description:
                return "descrição"
            }
        }
    }
    
    var name: String?
    var price: String?
    var category: String?
    var size: String?
    var condition: String?
    var brand: String?
    var description: String?
    var imageUrl: String?
}
