//
//  LoadingCell.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 11/10/22.
//

import UIKit

final class LoadingCell: UITableViewCell {

    // MARK: Private Properties
    private lazy var label: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Carregando categorias..."
        element.font = .nunito(style: .bold, size: 18)
        element.textColor = Asset.Colors.lightRed.color
        element.numberOfLines = 0
        element.textAlignment = .center
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
}

// MARK: - ViewCodable
extension LoadingCell: ViewCodable {
    public func buildViewHierarchy() {
        contentView.addSubview(label)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    public func setupAdditionalConfiguration() {
        selectionStyle = .none
    }
}
