//
//  AddPhotoCell.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 03/10/22.
//

import UIKit

public class AddPhotoCell: UICollectionViewCell {
    // MARK: - Private Properties
    
    private lazy var addPhotoLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontFamily.Nunito.semiBold.font(size: 16)
//        element.font = .nunito(style: .semiBold, size: 16)
        element.textColor = Asset.Colors.lightRed.color
        element.numberOfLines = 2
        element.textAlignment = .center
        element.text = "adicionar\nfoto"
        element.isUserInteractionEnabled = false
        return element
    }()
    
    private lazy var addPhotoIcon: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = .init(named: "add-photo")
        element.tintColor = Asset.Colors.lightRed.color
        element.isUserInteractionEnabled = false
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
}

// MARK: - ViewCodable
extension AddPhotoCell: ViewCodable {
    public func buildViewHierarchy() {
        contentView.addSubview(addPhotoIcon)
        contentView.addSubview(addPhotoLabel)
    }

    public func setupConstraints() {
        NSLayoutConstraint.activate([
            addPhotoIcon.widthAnchor.constraint(equalToConstant: 25),
            addPhotoIcon.heightAnchor.constraint(equalToConstant: 25),
            addPhotoIcon.topAnchor.constraint(equalTo: topAnchor, constant: 48),
            addPhotoIcon.centerXAnchor.constraint(equalTo: centerXAnchor),

            addPhotoLabel.topAnchor.constraint(equalTo: addPhotoIcon.bottomAnchor, constant: 4),
            addPhotoLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            addPhotoLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    public func setupAdditionalConfiguration() {
        contentView.backgroundColor = Asset.Colors.lightGray.color
        contentView.layer.borderColor = Asset.Colors.lightRed.color.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
    }
}
