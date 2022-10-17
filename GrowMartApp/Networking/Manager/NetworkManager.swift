//
//  NetworkManager.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 17/10/22.
//

import Foundation

enum NetworkErrorResponse: Error, Equatable {
    case invalidURL
    case errorGeneric(description: String)
    case invalidResponse
    case invalidData
    case errorDecoder
}

final class NetworkManager {
    let router = Router()

    // MARK: - Public Methods
    func getCategories(completion: @escaping (Result<CategoriesResponse, NetworkErrorResponse>) -> Void) {
        router.request(CategoriesApi.list) { data, response, error in
            if let error = error {
                return completion(.failure(.errorGeneric(description: error.localizedDescription)))
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                return completion(.failure(.invalidResponse))
            }
            
            guard let data = data else {
                return completion(.failure(.invalidData))
            }
            
            do {
                let result = try JSONDecoder().decode(CategoriesResponse.self, from: data)
                completion(.success(result))
            } catch (let error) {
                print(error)
                completion(.failure(.errorDecoder))
            }
        }
    }
}
