//
//  CartFooterView.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 10/09/22.
//

import UIKit

public protocol CartFooterViewDelegate: AnyObject {
    func didTapButton()
}

public final class CartFooterView: UIView {
    
    // MARK: Public Properties
    public weak var delegate: CartFooterViewDelegate?
        
    // MARK: Private Properties
    private lazy var lineView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(rgb: 0xFF6E40)
        return element
    }()
    
    private lazy var label: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .nunito(style: .regular, size: 18)
        element.numberOfLines = 1
        element.textAlignment = .right
        element.textColor = .black
        element.text = "total: R$ 0.00"
        return element
    }()

    private lazy var button: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.cornerRadius = 5
        element.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        element.configuration = .makeWith(backgroundColor: .init(rgb: 0xFFC13B),
                                          title: "check-out",
                                          font: .nunito(style: .semiBold, size: 18))
        return element
    }()

    // MARK: - Inits
    init(total: String, buttonTitle: String, delegate: CartFooterViewDelegate) {
        super.init(frame: .init(x: 0, y: 0, width: 0, height: 145))
        self.delegate = delegate
        label.text = total
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        setupView()
    }

    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: Public Methods
       
       func updateTotal(value: String) {
           label.text = value
       }

    // MARK: Actions

    @objc
    func didTapButton() {
        delegate?.didTapButton()
    }
}

extension CartFooterView: ViewCodable {
    public func buildViewHierarchy() {
        addSubview(label)
        addSubview(lineView)
        addSubview(button)
    }

    public func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),

            lineView.topAnchor.constraint(equalTo: label.bottomAnchor),
            lineView.widthAnchor.constraint(equalToConstant: 150),
            lineView.heightAnchor.constraint(equalToConstant: 3),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),

            button.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 32),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        ])

        // Comentar com o pessoal porque precisei fazer essas outras constantes dessa forma aqui...
        // #MeCobrem =)
        
        let labelTrailingConstraint = label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        labelTrailingConstraint.priority = .defaultLow
        labelTrailingConstraint.isActive = true

        let buttonBottomConstraint = button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        buttonBottomConstraint.priority = .defaultLow
        buttonBottomConstraint.isActive = true
        
        let buttonTrailingConstraint = button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        buttonTrailingConstraint.priority = .defaultLow
        buttonTrailingConstraint.isActive = true
    }
    
    public func setupAdditionalConfiguration() {
    }
}
