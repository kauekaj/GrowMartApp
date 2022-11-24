//
//  Fixtures.swift
//  GrowMartAppTests
//
//  Created by Kaue de Assis Jacyntho on 24/11/22.
//

@testable import GrowMartApp

extension ProductResponse {
    static func fixture() -> ProductResponse {
        .init(id: "1",
              name: "Test",
              image: nil,
              price: "R$ 999",
              category: nil,
              description: "Test test...",
              size: "XXL",
              condition: "Novo",
              brand: "Nike",
              otherInfos: nil,
              seller: nil)
    }
}
