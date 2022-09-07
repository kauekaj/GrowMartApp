//
//  TotalCell.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 07/09/22.
//

import UIKit

public final class TotalCell: UITableViewCell {

    // MARK: - Private Properties

    private lazy var lineView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(rgb: 0xFF6E40)
        return element
    }()

    private lazy var label: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .nunito(style: .regular, size: 18)
        element.numberOfLines = 1
        element.textAlignment = .right
        element.textColor = .black
        element.text = "total: R$ 0.00"
        return element
    }()

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

    public func setTotal(_ value: String) {
        label.text = value
    }

}

extension TotalCell: ViewCodable {
    public func buildViewHierarchy() {
        contentView.addSubview(lineView)
        contentView.addSubview(label)
    }

    public func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),

            lineView.topAnchor.constraint(equalTo: label.bottomAnchor),
            lineView.widthAnchor.constraint(equalToConstant: 150),
            lineView.heightAnchor.constraint(equalToConstant: 3),
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
    }

    public func setupAdditionalConfiguration() {
        selectionStyle = .none
    }
}
