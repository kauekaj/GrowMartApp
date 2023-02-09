//
//  ProductCell.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 07/09/22.
//

import UIKit

protocol CartItemCellDelegate: AnyObject {
    func remove(cartItem: CartItem)
}

class CartItemCell: UITableViewCell {

    public weak var delegate: CartItemCellDelegate?

    // MARK: - Private Properties
    
    private var cartItem: CartItem?

    private lazy var containerView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .white
        element.layer.cornerRadius = 5
        element.layer.borderWidth = 1
        element.layer.borderColor = Asset.Colors.baseYellow.color.cgColor
        element.clipsToBounds = true
        return element
    }()

    private lazy var productImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.masksToBounds = true
        element.contentMode = .scaleAspectFit
        element.layer.borderWidth = 1
        element.layer.borderColor = Asset.Colors.baseYellow.color.cgColor
        return element
    }()

    private lazy var nameLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontFamily.Nunito.medium.font(size: 16)
//        element.font = .nunito(style: .medium, size: 16)
        element.textColor = .black
        element.numberOfLines = 0
        element.textAlignment = .left
        return element
    }()

    private lazy var priceLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontFamily.Nunito.regular.font(size: 16)
//        element.font = .nunito(style: .regular, size: 16)
        element.textColor = Asset.Colors.gray.color
        element.numberOfLines = 0
        element.textAlignment = .left
        return element
    }()

    private lazy var removeButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitle("remover", for: .normal)
        element.setTitleColor(Asset.Colors.baseYellow.color, for: .normal)
        element.addTarget(self, action: #selector(didTapRemoveButton), for: .touchUpInside)
//        element.configuration = .makeWith(backgroundColor: .clear,
//                                          title: "remover",
//                                          font: .nunito(style: .regular, size: 14))
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
    public func setCartItem(_ cartItem: CartItem) {
        self.cartItem = cartItem

        productImageView.addImageFromURL(urlString: cartItem.image ?? "")
        nameLabel.text = cartItem.name
        priceLabel.text = cartItem.price
    }
    
    // MARK: - Actions
    @objc
    private func didTapRemoveButton() {
        guard let cartItem = cartItem else {
            return
        }
        delegate?.remove(cartItem: cartItem)
    }

}

// MARK: - ViewCodable
extension CartItemCell: ViewCodable {
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
