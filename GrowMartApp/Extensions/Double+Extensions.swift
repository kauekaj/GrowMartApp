//
//  Double+Extensions.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 10/01/23.
//

import Foundation

extension Double {
    
    func asMoney() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // USA: Locale(identifier: "en_US")
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        let formattedValue = formatter.string(from: NSNumber(value: self)) ?? ""
        
        return "R$ \(formattedValue)"
    }
}
