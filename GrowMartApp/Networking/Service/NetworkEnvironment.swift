//
//  NetworkEnvironment.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 27/10/22.
//

enum NetworkEnvironment: String {
    case debug = "Debug"
    case mock = "Mock"
    case release = "Release"
    
    func getBaseUrl() -> String {
        switch self {
        case .debug, .release: return "https://growmart-api.herokuapp.com/v1/"
        case .mock: return ""
        }
    }
}
