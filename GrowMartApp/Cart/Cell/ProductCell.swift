//
//  ProductCell.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 07/09/22.
//

import UIKit

public protocol ProductCellDelegate: AnyObject {
    func remove(product: Product)
}

public class ProductCell: UITableViewCell {
    
    public weak var delegate: ProductCellDelegate?

    // MARK: - Private Properties
    
    private var product: Product?
    
    private lazy var containerView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .white
        element.layer.cornerRadius = 5
        element.layer.borderWidth = 1
        element.layer.borderColor = UIColor(rgb: 0xFFC13B).cgColor
        element.clipsToBounds = true
        return element
    }()
    
    private lazy var productImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.masksToBounds = true
        element.contentMode = .scaleAspectFit
        element.layer.borderWidth = 1
        element.layer.borderColor = UIColor(rgb: 0xFFC13B).cgColor
        return element
    }()
    
    private lazy var nameLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .nunito(style: .medium, size: 16)
        element.textColor = .black
        element.numberOfLines = 0
        element.textAlignment = .left
        return element
    }()

    private lazy var priceLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .nunito(style: .regular, size: 16)
        element.textColor = UIColor(rgb: 0xA0A4A8)
        element.numberOfLines = 0
        element.textAlignment = .left
        return element
    }()
    
    private lazy var removeButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitleColor(.init(rgb: 0x4267B2), for: .normal)
        element.addTarget(self, action: #selector(didTapRemoveButton), for: .touchUpInside)
        element.configuration = .makeWith(backgroundColor: .clear,
                                          title: "remover",
                                          font: .nunito(style: .regular, size: 14))
        return element
    }()

    // MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Public Methods
    public func setProduct(_ product: Product) {
        self.product = product

        productImageView.image = UIImage(named: product.imageName)
        nameLabel.text = product.name
        priceLabel.text = product.price
    }
    
    // MARK: - Actions
    @objc
    private func didTapRemoveButton() {
        guard let product = product else {
            return
        }

        delegate?.remove(product: product)
    }

}

// MARK: - ViewCodable
extension ProductCell: ViewCodable {
    public func buildViewHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(productImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(removeButton)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 80),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            productImageView.widthAnchor.constraint(equalToConstant: 80),
            productImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),

            priceLabel.heightAnchor.constraint(equalToConstant: 40),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: removeButton.leadingAnchor, constant: 16),
            priceLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

            removeButton.widthAnchor.constraint(equalToConstant: 80),
            removeButton.heightAnchor.constraint(equalToConstant: 40),
            removeButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            removeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            removeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    public func setupAdditionalConfiguration() {
        selectionStyle = .none
    }
}
