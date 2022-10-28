//
//  CategoriesEndpoint.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 26/10/22.
//

import Foundation

// MARK: - Request
public enum CategoriesApi {
    case get(id: Int)
    case list
}

extension CategoriesApi: EndpointType {
    var baseURL: URL {
        guard let schemeName = Bundle.main.infoDictionary?["CURRENT_SCHEME_NAME"] as? String,
            let environment = NetworkEnvironment(rawValue: schemeName) else {
            fatalError("baseURL could not be configured.")
        }

        switch environment {
        case .mock:
            guard let path = Bundle.main.path(forResource: getMockName(), ofType: "json") else {
                fatalError("Mock not found.")
            }
            
            return NSURL.fileURL(withPath: path)
        case .debug, .release:
            guard let url = URL(string: environment.getBaseUrl()) else {
                fatalError("baseURL could not be configured.")
            }

            return url
        }
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var task: HTTPTask {
        .request
    }
    
    var headers: HTTPHeaders? {
        nil
    }
    
    func getFullURL() -> URL {
        guard let schemeName = Bundle.main.infoDictionary?["CURRENT_SCHEME_NAME"] as? String,
            let environment = NetworkEnvironment(rawValue: schemeName) else {
            fatalError("baseURL could not be configured.")
        }

        if environment == .mock {
            return baseURL
        } else {
            return baseURL.appendingPathComponent(path)
            // "https://growmart-api.herokuapp.com/v1/" + "categories"
            // "https://growmart-api.herokuapp.com/v1/categories"
        }
    }
    
    var path: String {
        switch self {
        case let .get(id): return "categorie/\(id)"
        case .list: return "categories"
        }
    }
        
    func getMockName() -> String {
        switch self {
        case let .get(id): return "categorie-\(id)"
        case .list: return "Categories"
        }
    }
}

// MARK: - Response
struct CategoriesResponse: Codable {
    var entries: [CategoryResponse]?
}

struct CategoryResponse: Codable {
    var id: String?
    var name: String?
    var image: String?
}
