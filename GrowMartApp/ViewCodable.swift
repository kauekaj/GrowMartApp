//
//  ViewCodable.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 23/08/22.
//

public protocol ViewCodable: AnyObject {
    func buildHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

public extension ViewCodable {
    func setupView() {
        buildHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
