//
//  UIButton.Configuration+Extension.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 07/09/22.
//

import UIKit

extension UIButton.Configuration {
    public static func makeWith(backgroundColor: UIColor,
                                title: String = "",
                                font: UIFont,
                                icon: UIImage? = nil) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        let attributeContainer = AttributeContainer([NSAttributedString.Key.font : font])
        configuration.attributedTitle = AttributedString(title, attributes: attributeContainer)
        configuration.image = icon
        configuration.titlePadding = 10
        configuration.imagePadding = 30
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        configuration.background.backgroundColor = backgroundColor
        return configuration
    }
}
