//
//  CartItem.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 09/01/23.
//

import Foundation

struct CartItem {
    let identifier: String?
    let image: String?
    let name: String?
    let price: String?
    
    func getPriceAsDouble() -> Double {
            guard var price = price else { return 0 }
            price = price.replacingOccurrences(of: "R$ ", with: "")
            return NumberFormatter().number(from: price)?.doubleValue ?? 0
        }
}
