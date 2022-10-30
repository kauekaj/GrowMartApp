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
    case list(page: Int, pageSize: Int)
}

extension ProductsApi: EndpointType {
    var path: String {
        switch self {
        case let .get(id): return "product/\(id)"
        case .list: return "products"
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .get: return .request
        case let .list(page, pageSize):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "page": page,
                                        "pageSize": pageSize
                                      ])
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
    let pagination: Pagination?
}

struct Pagination: Codable, Equatable {
    let page: Int?
    let totalEntries: Int?
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
}

struct SellerResponse: Codable, Equatable {
    let name: String?
    let memberSince: String?
    let sales: Int?
}
