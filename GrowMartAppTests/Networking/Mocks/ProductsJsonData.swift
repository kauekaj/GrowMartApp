//
//  ProductsJsonData.swift
//  GrowMartAppTests
//
//  Created by Kaue de Assis Jacyntho on 01/11/22.
//

let ProductsJsonData = """
{
    "entries": [
        {
            "id": "b4fe2451-00f2-4ff2-a67b-e396a35f6feb",
            "image": "https://picsum.photos/150/230",
            "name": "Nome do produto",
            "price": "R$ 99,99",
            "category": {
                "id": "b4fe2451-00f2-4ff2-a67b-e396a35f6feb",
                "image": "https://picsum.photos/200/300",
                "name": "ACESSÓRIOS"
            }
        },{
            "id": "b4fe2451-00f2-4ff2-a67b-e396a35f6feb",
            "image": "https://picsum.photos/150/230",
            "name": "Nome do produto",
            "price": "R$ 99,99",
            "category": {
                "id": "b4fe2451-00f2-4ff2-a67b-e396a35f6feb",
                "image": "https://picsum.photos/200/300",
                "name": "ACESSÓRIOS"
            }
        }
    ],
    "pagination": {
        "page": 1,
        "totalEntries": 200
    }
}
""".data(using: .utf8)
