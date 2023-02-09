//
//  HeaderView.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 21/09/22.
//

import UIKit

protocol HeaderViewDelegate: AnyObject {
    func didTapIconImageView()
}

class HeaderView: UIView {
    // MARK: - Public Properties
    weak var delegate: HeaderViewDelegate?

    // MARK: - Private Properties
    private let title: String
    private let icon: UIImage?
    private let roundedIcon: Bool
    
    private lazy var label: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
//        element.font = .nunito(style: .extraBold, size: 22)
        element.font = FontFamily.Nunito.extraBold.font(size: 22)
        element.textColor = .black
        element.numberOfLines = 1
        element.textAlignment = .left
        element.text = "meu perfil"
        return element
    }()
    
    private lazy var iconImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.masksToBounds = true
        element.contentMode = .scaleToFill
        element.isUserInteractionEnabled = true
        
        if roundedIcon {
            element.layer.cornerRadius = 25
        }
        
        return element
    }()
    
    // MARK: - Inits
    init(title: String, icon: UIImage? = nil, roundedIcon: Bool = false) {
        self.title = title
        self.icon = icon
        self.roundedIcon = roundedIcon
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: - Public Methods
    
    func updateIconImageView(image: UIImage) {
        iconImageView.image = image
    }

    // MARK: - Actions
    
    @objc
    private func didTapIconImageView() {
        delegate?.didTapIconImageView()
    }
}

extension HeaderView: ViewCodable {
    func buildViewHierarchy() {
        addSubview(label)
        addSubview(iconImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 50),
            iconImageView.heightAnchor.constraint(equalToConstant: 50),
            
            label.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor, constant: -64),
            label.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupAdditionalConfiguration() {
        label.text = title
        iconImageView.image = icon
        
        if icon != nil {
            let tap = UITapGestureRecognizer(target: self, action: #selector(didTapIconImageView))
            iconImageView.addGestureRecognizer(tap)
        }
    }
}
