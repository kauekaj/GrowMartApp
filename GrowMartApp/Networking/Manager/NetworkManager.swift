//
//  NetworkManager.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 17/10/22.
//

import Foundation

enum NetworkResponse: Error, Equatable {
    case invalidURL
    case errorGeneric(description: String)
    case invalidResponse
    case invalidData
    case errorDecoder
}

final class NetworkManager {
    let router: NetworkRouter
    
    init(router: NetworkRouter = Router()) {
        self.router = router
    }

    // MARK: - Public Methods
    public func execute<T>(endpoint: EndpointType,
                           completion: @escaping (Result<T, NetworkResponse>) -> Void
    ) where T : Decodable {
        router.request(endpoint) { [weak self] data, response, error in
            self?.handleReponse(data: data,
                                response: response,
                                error: error,
                                completion: completion)
        }
    }

    // MARK: - Private Methods
    
    fileprivate func handleReponse<T>(data: Data?,
                                      response: URLResponse?,
                                      error: Error?,
                                      completion: @escaping (Result<T, NetworkResponse>) -> Void
    ) where T : Decodable {
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
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch (let error) {
            print(error)
            completion(.failure(.errorDecoder))
        }
    }
}
