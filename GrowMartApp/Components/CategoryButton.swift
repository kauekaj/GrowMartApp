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

    private let title: String
    private let imageSide: ImageSide
    private let image: UIImage?

    // MARK: - Private Properties
    private lazy var label: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = UIFont.nunito(style: .extraBold, size: 25)
        element.textColor = UIColor(red: 1, green: 0.431, blue: 0.251, alpha: 1)
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

    // MARK: - Inits
    internal init(title: String, imageSide: CategoryButton.ImageSide, image: UIImage?) {
        self.title = title
        self.imageSide = imageSide
        self.image = image
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }

    required init?(coder: NSCoder) {
        nil
    }

}

extension CategoryButton: ViewCodable {
    func buildViewHierarchy() {
        addSubview(label)
        addSubview(imageView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 100),
        
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.heightAnchor.constraint(equalToConstant: 45),

            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 140),
            imageView.widthAnchor.constraint(equalToConstant: 140)

        ])
        
        switch imageSide {
        case .left:
            configureButtonLeft()
        case .right:
            configureButtonRight()
        }
    }

    func setupAdditionalConfiguration() {
        backgroundColor = UIColor(red: 0.961, green: 0.941, blue: 0.882, alpha: 1)
        layer.cornerRadius = 35
        label.text = title
        imageView.image = image
    }

    private func configureButtonLeft() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func configureButtonRight() {
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: imageView.leadingAnchor)
        ])
    }
    
}
