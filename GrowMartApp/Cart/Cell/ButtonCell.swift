//
//  ButtonCell.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 07/09/22.
//

import UIKit

public protocol ButtonCellDelegate: AnyObject {
    func didTapButton()
}

public final class ButtonCell: UITableViewCell {

    // MARK: - Public Properties
    public weak var delegate: ButtonCellDelegate?
    
    // MARK: - Private Properties
    private lazy var button: UIButton = {
            let element = UIButton()
            element.translatesAutoresizingMaskIntoConstraints = false
            element.layer.cornerRadius = 5
            element.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            element.configuration = .makeWith(backgroundColor: .init(rgb: 0xFFC13B),
                                              title: "check-out",
                                              font: .nunito(style: .semiBold, size: 18))
            return element
        }()
}
