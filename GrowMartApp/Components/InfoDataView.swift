//
//  InfoDataView.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 21/09/22.
//

import UIKit

class InfoDataView: UIStackView {
    
    private var title: String
    private var infos: [(leftValue: String, rightValue: String)]
    private var footerTitle: String?
    private var footerMessage: String?

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
    
    private lazy var footerTitleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .nunito(style: .bold, size: 12)
        element.textColor = .black
        element.numberOfLines = 0
        return element
    }()
    
    private lazy var footerMessageLabel: UILabel = {
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
    
    // MARK: - Public Methods
    
    func updateData(infos: [(String, String)],
                    footerTitle: String? = nil,
                    footerMessage: String? = nil) {
        self.infos = infos
        self.footerTitle = footerTitle
        self.footerMessage = footerMessage
        arrangedSubviews.forEach({ $0.removeFromSuperview() })
        labelValues.removeAll()
        setupView()
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
        
        if let message = footerMessage, !message.isEmpty {
            addArrangedSubview(lineView)
            if let title = footerTitle, !title.isEmpty {
                addArrangedSubview(footerTitleLabel)
            }
            addArrangedSubview(footerMessageLabel)
        }
    }
    
    func setupConstraints() {
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true

        labelValues.forEach {
            $0.widthAnchor.constraint(equalTo: widthAnchor, constant: -32).isActive = true
        }
        
        if let value = footerMessage, !value.isEmpty {
            if let title = footerTitle, !title.isEmpty {
                footerTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -32).isActive = true
            }
            
            NSLayoutConstraint.activate([
                lineView.widthAnchor.constraint(equalTo: widthAnchor, constant: -32),
                lineView.heightAnchor.constraint(equalToConstant: 1),
                footerMessageLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -32)
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
        footerTitleLabel.text = footerTitle
        footerMessageLabel.text = footerMessage

        setCustomSpacing(16, after: titleLabel)
        
        if let value = footerMessage, !value.isEmpty,
           let lastItem = labelValues.last {
            setCustomSpacing(16, after: lastItem)
            setCustomSpacing(16, after: lineView)
        }
    }
}
