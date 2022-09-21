//
//  InfoDataView.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 21/09/22.
//

import UIKit

class InfoDataView: UIStackView {
    
    private let title: String
    private let infos: [(leftValue: String, rightValue: String)]
    private let footerMessage: String?
    
    private var labelValues = [LabelValueView]()

    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .nunito(style: .bold, size: 14)
        element.textColor = .white
        element.backgroundColor = .init(rgb: 0x1E3D59)
        element.numberOfLines = 1
        element.textAlignment = .center
        return element
    }()
    
    private lazy var lineView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(rgb: 0xE8E8E8)
        return element
    }()
    
    private lazy var footerLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .nunito(style: .regular, size: 12)
        element.textColor = .black
        element.numberOfLines = 0
        return element
    }()
    
    // MARK: - Inits
    init(title: String,
         infos: [(String, String)],
         footerMessage: String? = nil) {
        self.title = title
        self.infos = infos
        self.footerMessage = footerMessage
        super.init(frame: .zero)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InfoDataView: ViewCodable {
    func buildViewHierarchy() {
        addArrangedSubview(titleLabel)
        
        infos.forEach { info in
            let element = LabelValueView(leftValue: info.leftValue,
                                         rightValue: info.rightValue)
            labelValues.append(element)
            addArrangedSubview(element)
        }
        
        if let value = footerMessage, !value.isEmpty {
            addArrangedSubview(lineView)
            addArrangedSubview(footerLabel)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        labelValues.forEach({ element in
            NSLayoutConstraint.activate([
                element.widthAnchor.constraint(equalTo: widthAnchor, constant: -32),
                element.heightAnchor.constraint(equalToConstant: 30)
            ])
        })
        
        if let value = footerMessage, !value.isEmpty {
            NSLayoutConstraint.activate([
                lineView.widthAnchor.constraint(equalTo: widthAnchor, constant: -32),
                lineView.heightAnchor.constraint(equalToConstant: 1),
                footerLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -32),
                footerLabel.heightAnchor.constraint(equalToConstant: 25)
            ])
        }
    }
    
    func setupAdditionalConfiguration() {
        axis = .vertical
        distribution = .fill
        layer.cornerRadius = 5
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor(rgb: 0x2B577F).cgColor
        alignment = .center
        
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = .init(top: 0, leading: 0, bottom: 16, trailing: 0)

        titleLabel.text = title
        footerLabel.text = footerMessage
        
        setCustomSpacing(16, after: titleLabel)
        
        if let value = footerMessage, !value.isEmpty,
           let lastItem = labelValues.last {
            setCustomSpacing(16, after: lastItem)
            setCustomSpacing(16, after: lineView)
        }
    }
}
