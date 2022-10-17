//
//  URLParameterEncoder.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 17/10/22.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest,
                       with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw ParameterEncodingError.missingURL }
        
        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = []
            
            for (key, value) in parameters {
                urlComponents.queryItems?.append(.init(
                    name: key,
                    value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                ))
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8",
                                forHTTPHeaderField: "Content-Type")
        }
    }
}
