//
//  LabelValueView.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 21/09/22.
//

import UIKit

class LabelValueView: UIStackView {
    
    private let leftValue: String
    private let rightValue: String

    private lazy var leftLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .nunito(style: .medium, size: 12)
        element.textColor = Asset.Colors.gray.color
        element.numberOfLines = 1
        return element
    }()
    
    private lazy var rightLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .nunito(style: .regular, size: 12)
        element.textColor = .black
        element.numberOfLines = 0
        return element
    }()
    
    // MARK: - Inits
    init(leftValue: String, rightValue: String) {
        self.leftValue = leftValue
        self.rightValue = rightValue
        super.init(frame: .zero)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LabelValueView: ViewCodable {
    func buildViewHierarchy() {
        addArrangedSubview(leftLabel)
        addArrangedSubview(rightLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            leftLabel.widthAnchor.constraint(equalToConstant: 70),
            leftLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupAdditionalConfiguration() {
        spacing = 4
        axis = .horizontal
        distribution = .fill
        
        leftLabel.text = leftValue
        rightLabel.text = rightValue
    }
}
