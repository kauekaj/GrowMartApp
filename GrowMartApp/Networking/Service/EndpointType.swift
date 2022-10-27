//
//  EndpointType.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 27/10/22.
//

import Foundation

protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    
    func getMockName() -> String
    func getFullURL() -> URL
}

// MARK: - Default implementations
extension EndpointType {
    
}
