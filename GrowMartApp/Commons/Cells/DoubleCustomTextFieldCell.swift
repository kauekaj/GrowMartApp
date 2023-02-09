//
//  DoubleCustomTextFieldCell.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 26/09/22.
//

import UIKit

public protocol DoubleCustomTextFieldCellDelegate: AnyObject {
    func didChangeValue(propertyName: String?, value: String)
}

public final class DoubleCustomTextFieldCell: UITableViewCell {
    
    // MARK: Public Properties
    public weak var delegate: DoubleCustomTextFieldCellDelegate?
    public var leftFieldPropertyName: String?
    public var rightFieldPropertyName: String?

    // MARK: Private Properties
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .horizontal
        element.spacing = 32
        element.distribution = .fillEqually
        return element
    }()
    
    private lazy var leftStackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .vertical
        element.alignment = .center
        element.distribution = .fill
        return element
    }()

    private lazy var leftTitleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .nunito(style: .medium, size: 14)
        element.textColor = .black
        element.numberOfLines = 0
        element.textAlignment = .left
        return element
    }()
    
    private lazy var leftTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.borderStyle = .none
        element.font = .nunito(style: .regular, size: 16)
        element.delegate = self
        return element
    }()
    
    private lazy var leftLineView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = Asset.Colors.midBlue.color
        return element
    }()
    
    private lazy var rightStackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .vertical
        element.alignment = .center
        element.distribution = .fill
        return element
    }()

    private lazy var rightTitleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .nunito(style: .medium, size: 14)
        element.textColor = .black
        element.numberOfLines = 0
        element.textAlignment = .left
        return element
    }()
    
    private lazy var rightTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.borderStyle = .none
        element.font = .nunito(style: .regular, size: 16)
        element.delegate = self
        return element
    }()
    
    private lazy var rightLineView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = Asset.Colors.midBlue.color
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
    public func setData(leftTitle: String,
                        leftValue: String?,
                        rightTitle: String,
                        rightValue: String?) {
        leftTitleLabel.text = leftTitle
        leftTextField.placeholder = leftTitle
        leftTextField.text = leftValue

        rightTitleLabel.text = rightTitle
        rightTextField.placeholder = rightTitle
        rightTextField.text = rightValue
    }
}

extension DoubleCustomTextFieldCell: ViewCodable {
    public func buildViewHierarchy() {
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(leftStackView)
        mainStackView.addArrangedSubview(rightStackView)
        
        leftStackView.addArrangedSubview(leftTitleLabel)
        leftStackView.addArrangedSubview(leftTextField)
        leftStackView.addArrangedSubview(leftLineView)
        
        rightStackView.addArrangedSubview(rightTitleLabel)
        rightStackView.addArrangedSubview(rightTextField)
        rightStackView.addArrangedSubview(rightLineView)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            leftTitleLabel.leadingAnchor.constraint(equalTo: leftStackView.leadingAnchor, constant: 32),
            leftTitleLabel.heightAnchor.constraint(equalToConstant: 23),
            
            leftTextField.leadingAnchor.constraint(equalTo: leftStackView.leadingAnchor, constant: 32),
            leftTextField.heightAnchor.constraint(equalToConstant: 31),
            
            leftLineView.leadingAnchor.constraint(equalTo: leftStackView.leadingAnchor),
            leftLineView.trailingAnchor.constraint(equalTo: leftStackView.trailingAnchor),
            leftLineView.heightAnchor.constraint(equalToConstant: 2),

            rightTitleLabel.leadingAnchor.constraint(equalTo: rightStackView.leadingAnchor, constant: 32),
            rightTitleLabel.heightAnchor.constraint(equalToConstant: 23),
            
            rightTextField.leadingAnchor.constraint(equalTo: rightStackView.leadingAnchor, constant: 32),
            rightTextField.heightAnchor.constraint(equalToConstant: 31),
            
            rightLineView.leadingAnchor.constraint(equalTo: rightStackView.leadingAnchor),
            rightLineView.trailingAnchor.constraint(equalTo: rightStackView.trailingAnchor),
            rightLineView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    public func setupAdditionalConfiguration() {
        selectionStyle = .none
    }
}

// MARK: - UITextFieldDelegate
extension DoubleCustomTextFieldCell: UITextFieldDelegate {
    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        guard let text = textField.text as NSString? else {
            return false
        }
        
        var propertyName = leftFieldPropertyName
        if textField == rightTextField {
            propertyName = rightFieldPropertyName
        }

        delegate?.didChangeValue(propertyName: propertyName,
                                 value: text.replacingCharacters(in: range, with: string))
        return true
    }
}
