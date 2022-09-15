//
//  CatalogItemCell.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 14/09/22.
//

import UIKit

class CatalogItemCell: UICollectionViewCell {

    static var identifier: String {
           return String(describing: self)
       }
    
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
           element.backgroundColor = UIColor(rgb: 0xA0A4A8)
           return element
       }()

       private lazy var priceLabel: UILabel = {
           let element = UILabel()
           element.translatesAutoresizingMaskIntoConstraints = false
           element.font = .nunito(style: .medium, size: 14)
           element.textColor = .white
           element.numberOfLines = 1
           element.textAlignment = .left
           return element
       }()

       private lazy var nameLabel: UILabel = {
           let element = UILabel()
           element.translatesAutoresizingMaskIntoConstraints = false
           element.font = .nunito(style: .regular, size: 10)
           element.textColor = .white
           element.numberOfLines = 1
           element.textAlignment = .left
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

       // MARK: - Public Methods
       public func setup(with product: Product) {
           productImageView.addImageFromURL(urlString: product.imageUrl)
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
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])
    }

    public func setupAdditionalConfiguration() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(rgb: 0xA0A4A8).cgColor
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
    }
}
