//
//  SelectorView.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 02/09/22.
//

import UIKit

public protocol SelectorViewDelegate: AnyObject {
    func didSelectCategory(id: Int)
}

class SelectorView: UIView {
    
    // MARK: - Public Properties
    weak var delegate: SelectorViewDelegate?
    
    // MARK: - Private Properties
    private lazy var stackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .vertical
        element.spacing = 32
        return element
    }()
    
    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = UIFont.nunito(style: .extraBold, size: 30)
        element.textColor = UIColor(rgb: 0x1E3D59)
        element.text = "O que voce quer comprar?"
        element.numberOfLines = 0
        element.textAlignment = .left
        return element
    }()
    
    private lazy var buttonClothes = CategoryButton(categoryId: 1,
                                                    title: "roupas",
                                                    imageSide: .right,
                                                    image: UIImage(named: "roupas"))
    private lazy var buttonAcessories = CategoryButton(categoryId: 2,
                                                       title: "acessórios",
                                                       imageSide: .left,
                                                       image: UIImage(named: "acessorios"))
    private lazy var buttonOthers = CategoryButton(categoryId: 3,
                                                   title: "outros",
                                                   imageSide: .right,
                                                   image: UIImage(named: "outros"))
    
    // MARK: - Private Methods
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Actions
    @objc
    private func didTapButton(_ sender: UITapGestureRecognizer) {
        guard let button = sender.view as? CategoryButton else { return }
        delegate?.didSelectCategory(id: button.categoryId)
    }
}

// MARK: - View Code
extension SelectorView: ViewCodable {
    func buildViewHierarchy() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(buttonClothes)
        stackView.addArrangedSubview(buttonAcessories)
        stackView.addArrangedSubview(buttonOthers)
        stackView.setCustomSpacing(74, after: titleLabel)
        
        addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 92),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
        
        [buttonClothes, buttonAcessories, buttonOthers].forEach { button in
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapButton(_:)))
            button.addGestureRecognizer(tapGesture)
        }
    }
}
