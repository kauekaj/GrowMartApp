//
//  CheckboxCell.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 26/09/22.
//

import UIKit
import SimpleCheckbox

public protocol CheckboxCellDelegate: AnyObject {
    func didChangeCheckbox(propertyName: String?, isChecked: Bool)
}

public final class CheckboxCell: UITableViewCell {
    
    // MARK: Public Properties
    public weak var delegate: CheckboxCellDelegate?
    public var propertyName: String?
    
    // MARK: Private Properties
    private lazy var checkbox: Checkbox = {
        let element = Checkbox()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.checkmarkStyle = .tick
        element.checkedBorderColor = .black
        element.uncheckedBorderColor = .black
        element.valueChanged = { [weak self] isChecked in
            self?.delegate?.didChangeCheckbox(propertyName: self?.propertyName,
                                              isChecked: isChecked)
        }
        return element
    }()
    
    private lazy var label: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontFamily.Nunito.regular.font(size: 12)
//        element.font = .nunito(style: .regular, size: 12)
        element.textColor = .black
        element.numberOfLines = 0
        element.textAlignment = .left
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
    public func setData(text: String, isChecked: Bool) {
        checkbox.isChecked = isChecked
        label.text = text
    }
}

extension CheckboxCell: ViewCodable {
    public func buildViewHierarchy() {
        contentView.addSubview(checkbox)
        contentView.addSubview(label)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            checkbox.widthAnchor.constraint(equalToConstant: 15),
            checkbox.heightAnchor.constraint(equalToConstant: 15),
            checkbox.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            checkbox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            checkbox.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            label.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            label.centerYAnchor.constraint(equalTo: checkbox.centerYAnchor)
        ])
    }
    
    public func setupAdditionalConfiguration() {
        selectionStyle = .none
    }
}
