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
        element.configuration = .makeWith(backgroundColor: Asset.Colors.baseYellow.color,
                                          title: "check-out",
                                          font: .nunito(style: .semiBold, size: 18))
        return element
    }()

    // MARK: - Actions
    
    @objc
    func didTapButton() {
        delegate?.didTapButton()
    }

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
    public func setTitle(_ title: String, color: UIColor) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
    }
}

extension ButtonCell: ViewCodable {
    public func buildViewHierarchy() {
        contentView.addSubview(button)
    }

    public func setupConstraints() {
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 45),
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    public func setupAdditionalConfiguration() {
        selectionStyle = .none
    }
}
