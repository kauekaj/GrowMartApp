//
//  UITextField+Extensions.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 30/09/22.
//

import UIKit

extension UITextField {
    func loadDropdownData(data: [String]) {
        self.inputView = PickerView(data: data, textField: self)
    }
}
