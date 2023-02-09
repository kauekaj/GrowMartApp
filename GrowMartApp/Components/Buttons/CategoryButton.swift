//
//  CategoryButton.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 30/08/22.
//

import UIKit

class CategoryButton: UIControl {
    enum ImageSide {
        case left
        case right
    }

    private var imageSide: ImageSide = .right
    var categoryId: String?

    lazy var label: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = UIFont.nunito(style: .extraBold, size: 25)
        element.textColor = Asset.Colors.lightRed.color
        element.textAlignment = .center
        return element
    }()

    private lazy var imageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.masksToBounds = true
        element.contentMode = .scaleAspectFit
        return element
    }()

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        setupView()
    }

    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: - Public Methods
    func setData(categoryId: String, title: String, imageSide: ImageSide, imageUrl: String?) {
        self.categoryId = categoryId
        self.imageSide = imageSide
        
        if let imageUrl = imageUrl {
            imageView.addImageFromURL(urlString: imageUrl)
        }
        label.text = title
        
        switch imageSide {
        case .left:
            configureButtonForLeft()
        case .right:
            configureButtonForRight()
        }
    }
    
    // MARK: - Private Methods
    private func configureButtonForLeft() {
        label.constraints.forEach({ $0.isActive = false })
        imageView.constraints.forEach({ $0.isActive = false })

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.heightAnchor.constraint(equalToConstant: 45),

            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 140),
            imageView.widthAnchor.constraint(equalToConstant: 140),
            
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -8),

            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func configureButtonForRight() {
        // resetSubviews
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.heightAnchor.constraint(equalToConstant: 45),

            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 140),
            imageView.widthAnchor.constraint(equalToConstant: 140),
            
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8),

            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: imageView.leadingAnchor)
        ])
    }
}

// MARK: - View Code
extension CategoryButton: ViewCodable {
    func buildViewHierarchy() {
        addSubview(label)
        addSubview(imageView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = Asset.Colors.lightYellow.color
        layer.cornerRadius = 35
    }
}
