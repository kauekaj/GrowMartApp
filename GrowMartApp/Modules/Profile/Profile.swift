//
//  Profile.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 21/09/22.
//

public struct Profile {
    enum Field: String {
        case name
        case address
        case number
        case complement
        case email
        case cellphone
        case canShareWhatsapp
        
        func getFormattedName() -> String {
            switch self {
            case .name:
                return "nome"
            case .address:
                return "endereço"
            case .number:
                return "número"
            case .complement:
                return "complemento"
            case .email:
                return "email"
            case .cellphone:
                return "celular"
            case .canShareWhatsapp:
                return "compartilhar meu whatsapp"
            }
        }
    }
    
    var name: String?
    var address: String?
    var number: String?
    var complement: String?
    var email: String?
    var cellphone: String?
    var canShareWhatsapp: Bool?
}
