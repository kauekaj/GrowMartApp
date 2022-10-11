//
//  CategoriesResponse.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 11/10/22.
//

// MARK: - Response
struct CategoriesResponse: Codable {
    var entries: [CategoryResponse]?
}

struct CategoryResponse: Codable {
    var id: String?
    var name: String?
    var image: String?
}
