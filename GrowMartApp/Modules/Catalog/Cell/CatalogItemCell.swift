//
//  CatalogItemCell.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 14/09/22.
//

import UIKit

protocol CatalogItemCellDelegate: AnyObject {
    func didTapFavorite(id: String, isFavorite: Bool)
}

public class CatalogItemCell: UICollectionViewCell {

    weak var delegate: CatalogItemCellDelegate?
    
    // MARK: - Private Properties
    private lazy var productImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.masksToBounds = true
        element.contentMode = .scaleToFill
        element.backgroundColor = .lightGray
        return element
    }()
    
    private lazy var containerView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = Asset.Colors.gray.color
        return element
    }()

    private lazy var priceLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontFamily.Nunito.medium.font(size: 14)
//        element.font = .nunito(style: .medium, size: 14)
        element.textColor = .white
        element.numberOfLines = 1
        element.textAlignment = .left
        return element
    }()

    private lazy var nameLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontFamily.Nunito.regular.font(size: 10)
//        element.font = .nunito(style: .regular, size: 10)
        element.textColor = .white
        element.numberOfLines = 1
        element.textAlignment = .left
        return element
    }()
    
    private lazy var favoriteButton: FavoriteButton = {
        let element = FavoriteButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        return element
    }()

    // MARK: - Inits
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    public required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: Actions
    
    @objc
    private func didTapFavorite() {
        favoriteButton.toggleState()
        delegate?.didTapFavorite(id: favoriteButton.productId,
                                 isFavorite: favoriteButton.isFavorite)
    }
    
    // MARK: - Public Methods
    func setup(with product: ProductForCatalog, isFavorite: Bool) {
        favoriteButton.productId = product.id ?? ""
        favoriteButton.isFavorite = isFavorite

        productImageView.addImageFromURL(urlString: product.image ?? "")
        priceLabel.text = product.price
        nameLabel.text = product.name
    }
}

// MARK: - ViewCodable
extension CatalogItemCell: ViewCodable {
    public func buildViewHierarchy() {
        contentView.addSubview(productImageView)
        contentView.addSubview(containerView)
        containerView.addSubview(priceLabel)
        containerView.addSubview(nameLabel)
        containerView.addSubview(favoriteButton)
    }

    public func setupConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            containerView.heightAnchor.constraint(equalToConstant: 50),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            priceLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),

            nameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            favoriteButton.widthAnchor.constraint(equalToConstant: 32),
            favoriteButton.heightAnchor.constraint(equalToConstant: 32),
            favoriteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            favoriteButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }

    public func setupAdditionalConfiguration() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = Asset.Colors.gray.color.cgColor
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
    }
}
