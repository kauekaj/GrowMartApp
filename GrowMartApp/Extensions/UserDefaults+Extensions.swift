//
//  UserDefaults+Extensions.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 21/11/22.
//

import Foundation

protocol UserDefaultsActions {
    func set(_ value: Any?, forKey: String)
    func string(forKey: String) -> String?
    func integer(forKey: String) -> Int
    func object(forKey: String) -> Any?
}

extension UserDefaults: UserDefaultsActions {
    
}
