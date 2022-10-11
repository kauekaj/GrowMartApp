//
//  CategoryButtonCell.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 11/10/22.
//

import UIKit
public protocol CategoryButtonCellDelegate: AnyObject {
    func didTapCategoryButton(categoryId: String)
}

public final class CategoryButtonCell: UITableViewCell {
    
    // MARK: Public Properties
    public weak var delegate: CategoryButtonCellDelegate?
    
    // MARK: Private Properties
    private lazy var button: CategoryButton = {
        let element = CategoryButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return element
    }()
    
    // MARK: Actions
    
    @objc
    func didTapButton() {
        delegate?.didTapCategoryButton(categoryId: button.categoryId ?? "")
    }
    
    // MARK: Inits
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Public Methods
    func setData(categoryId: String,
                 title: String,
                 imageSide: CategoryButton.ImageSide,
                 imageUrl: String?) {
        button.setData(categoryId: categoryId,
                       title: title,
                       imageSide: imageSide,
                       imageUrl: imageUrl)
    }
}

extension CategoryButtonCell: ViewCodable {
    public func buildViewHierarchy() {
        contentView.addSubview(button)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    public func setupAdditionalConfiguration() {
        selectionStyle = .none
    }
}
