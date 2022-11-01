//
//  ProductDetailJsonData.swift
//  GrowMartAppTests
//
//  Created by Kaue de Assis Jacyntho on 01/11/22.
//

let ProductDetailJsonData = """
{
    "id": "b4fe2451-00f2-4ff2-a67b-e396a35f6feb",
    "image": "https://picsum.photos/300/300",
    "name": "Nome do produto",
    "price": "R$ 99,99",
    "category": {
        "id": "b4fe2451-00f2-4ff2-a67b-e396a35f6feb",
        "image": "https://picsum.photos/200/300",
        "name": "ACESSÓRIOS"
    },
    "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
    "size": "P",
    "condition": "usado",
    "brand": "Baw",
    "otherInfos": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
    "seller": {
        "name": "Nome do vendedor",
        "memberSince": "membro desde mm/yy",
        "sales": 4793
    }
}
""".data(using: .utf8)
