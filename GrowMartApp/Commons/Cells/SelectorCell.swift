//
//  SelectorCell.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 30/09/22.
//

import UIKit

public protocol SelectorCellDelegate: AnyObject {
    func didChangeValue(propertyName: String?, value: String)
}

public final class SelectorCell: UITableViewCell {
    
    // MARK: Public Properties
    public weak var delegate: SelectorCellDelegate?
    public var propertyName: String?

    // MARK: Private Properties
    private lazy var textField: RightIconTextField = {
        let element = RightIconTextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.borderStyle = .roundedRect
        element.tintColor = .black
        element.font = FontFamily.Nunito.regular.font(size: 18)
//        element.font = .nunito(style: .regular, size: 18)
        element.delegate = self
        element.rightViewMode = .always
        element.layer.borderColor = Asset.Colors.darkBlue.color.cgColor
        element.layer.borderWidth = 1
        element.layer.cornerRadius = 5
        element.rightView = UIImageView(image: Asset.Images.arrowDown.image)
        return element
    }()
        
    // MARK: Inits
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Public Methods
    public func setData(placeholder: String, value: String?, options: [String]) {
        textField.placeholder = placeholder
        textField.text = value
        textField.loadDropdownData(data: options)
    }
}

extension SelectorCell: ViewCodable {
    public func buildViewHierarchy() {
        contentView.addSubview(textField)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ])
    }
    
    public func setupAdditionalConfiguration() {
        selectionStyle = .none
    }
}

// MARK: - UITextFieldDelegate
extension SelectorCell: UITextFieldDelegate {
    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        guard let text = textField.text as NSString? else {
            return false
        }

        delegate?.didChangeValue(propertyName: propertyName,
                                 value: text.replacingCharacters(in: range, with: string))
        return true
    }
}
