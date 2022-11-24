//
//  AuthEndpoint.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 02/11/22.
//

import Foundation

// MARK: - Request
public enum AuthApi {
    case auth(login: String, password: String)
}

extension AuthApi: EndpointType {
    var path: String {
        switch self {
        case .auth: return "auth"
        }
    }
    
    var httpMethod: HTTPMethod {
        .post
    }
    
    var task: HTTPTask {
        switch self {
        case let .auth(login, password):
            return .requestParameters(bodyParameters: ["login": login, "password": password],
                                      bodyEncoding: .jsonEncoding,
                                      urlParameters: nil)
        }
    }
        
    func getMockName() -> String {
        switch self {
        case .auth: return "auth"
        }
    }
}

// MARK: - Response
struct AuthResponse: Codable, Equatable {
    var id: String?
    var name: String?
    var email: String?
    var phone: String?
}
