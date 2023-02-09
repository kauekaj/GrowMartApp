//
//  SellerView.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 28/10/22.
//

import UIKit

class SellerView: UIStackView {
    
    private var name: String = "" {
        didSet {
            nameLabel.text = name
        }
    }
    
    private var memberSince: String = "" {
        didSet {
            memberSinceLabel.text = memberSince
        }
    }
    
    private var sales: String = "" {
        didSet {
            salesLabel.text = sales
        }
    }

    private lazy var nameLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontFamily.Nunito.bold.font(size: 12)
//        element.font = .nunito(style: .bold, size: 18)
        element.textColor = .black
        element.numberOfLines = 1
        return element
    }()
    
    private lazy var memberSinceLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontFamily.Nunito.regular.font(size: 12)
//        element.font = .nunito(style: .regular, size: 12)
        element.textColor = Asset.Colors.gray.color
        element.numberOfLines = 1
        return element
    }()
    
    private lazy var salesLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontFamily.Nunito.regular.font(size: 14)
//        element.font = .nunito(style: .regular, size: 14)
        element.textColor = .black
        element.numberOfLines = 1
        return element
    }()
    
    // MARK: - Inits
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func updateData(name: String,
                    memberSince: String,
                    sales: String) {
        self.name = name
        self.memberSince = memberSince
        self.sales = sales
    }
}

extension SellerView: ViewCodable {
    func buildViewHierarchy() {
        addArrangedSubview(nameLabel)
        addArrangedSubview(memberSinceLabel)
        addArrangedSubview(salesLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            memberSinceLabel.heightAnchor.constraint(equalToConstant: 40),
            salesLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupAdditionalConfiguration() {
        axis = .vertical
        distribution = .fill
        layer.cornerRadius = 5
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = Asset.Colors.midBlue.color.cgColor
        
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
    }
}
