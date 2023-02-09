//
//  CustomTextFieldCell.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 24/09/22.
//

import UIKit

public protocol CustomTextFieldCellDelegate: AnyObject {
    func didChangeValue(propertyName: String?, value: String)
}

public final class CustomTextFieldCell: UITableViewCell {
    
    // MARK: - Public Properties
    public weak var delegate: CustomTextFieldCellDelegate?
    public var propertyName: String?
    
    // MARK: - Private Properties
    private lazy var titleLabel: UILabel = {
            let element = UILabel()
            element.translatesAutoresizingMaskIntoConstraints = false
            element.font = FontFamily.Nunito.medium.font(size: 14)
//            element.font = .nunito(style: .medium, size: 14)
            element.textColor = .black
            element.numberOfLines = 0
            element.textAlignment = .left
            return element
        }()
        
        private lazy var textField: UITextField = {
            let element = UITextField()
            element.translatesAutoresizingMaskIntoConstraints = false
            element.borderStyle = .none
            element.font = FontFamily.Nunito.regular.font(size: 16)
//            element.font = .nunito(style: .regular, size: 16)
            element.delegate = self
            return element
        }()
        
        private lazy var lineView: UIView = {
            let element = UIView()
            element.translatesAutoresizingMaskIntoConstraints = false
            element.backgroundColor = Asset.Colors.midBlue.color
            return element
        }()
    
    // MARK: - Actions
    
    // MARK: - Inits
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Public Methods
        
        public func setData(title: String, value: String?) {
            titleLabel.text = title
            
            textField.placeholder = title
            textField.text = value
        }
}

extension CustomTextFieldCell: ViewCodable {
    public func buildViewHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
        contentView.addSubview(lineView)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 64),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            titleLabel.heightAnchor.constraint(equalToConstant: 23),

            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 64),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            textField.heightAnchor.constraint(equalToConstant: 31),

            lineView.topAnchor.constraint(equalTo: textField.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    public func setupAdditionalConfiguration() {
        selectionStyle = .none
    }
}

extension CustomTextFieldCell: UITextFieldDelegate {
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
