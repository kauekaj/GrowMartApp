//
//  ProductsEndpoint.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 30/10/22.
//

import Foundation

// MARK: - Request
public enum ProductsApi {
    case get(id: String)
    case list(page: Int)
}

extension ProductsApi: EndpointType {
    var path: String {
        switch self {
        case let .get(id): return "product/\(id)"
        case .list: return "products"
        }
    }
        
    func getMockName() -> String {
        switch self {
        case .get: return "product-detail"
        case .list: return "products"
        }
    }
}

// MARK: - Response
struct ProductsResponse: Codable, Equatable {
    let entries: [ProductResponse]?
}

struct ProductResponse: Codable, Equatable {
    let id: String?
    let name: String?
    let image: String?
    let price: String?
    let category: CategoryResponse?
    let description: String?
    let size: String?
    let condition: String?
    let brand: String?
    let otherInfos: String?
    let seller: SellerResponse?
    
    init(id: String? = nil,
            name: String? = nil,
            image: String? = nil,
            price: String? = nil,
            category: CategoryResponse? = nil,
            description: String? = nil,
            size: String? = nil,
            condition: String? = nil,
            brand: String? = nil,
            otherInfos: String? = nil,
            seller: SellerResponse? = nil
       ) {
           self.id = id
           self.name = name
           self.image = image
           self.price = price
           self.category = category
           self.description = description
           self.size = size
           self.condition = condition
           self.brand = brand
           self.otherInfos = otherInfos
           self.seller = seller
       }
}

struct SellerResponse: Codable, Equatable {
    let name: String?
    let memberSince: String?
    let sales: Int?
}
