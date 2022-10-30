//
//  HomeEndpoint.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 30/10/22.
//

import Foundation

// MARK: - Request
public enum HomeApi {
    case get
    case getLastSearch
}

extension HomeApi: EndpointType {
    var path: String {
        switch self {
        case .get: return "home"
        case .getLastSearch: return "home/last-search"
        }
    }
        
    func getMockName() -> String {
        switch self {
        case .get: return "home"
        case .getLastSearch: return "home-last-search"
        }
    }
}

// MARK: - Response
struct HomeResponse: Codable, Equatable {
    
}
