//
//  ProductDetailView.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 28/10/22.
//

import UIKit

protocol ProductDetailViewDelegate: AnyObject {
    func didTapAddToCart()
    func didTapShare()
}

public final class ProductDetailView: BaseView {
    // MARK: - Public Properties
    weak var delegate: ProductDetailViewDelegate?
    
    // MARK: - Private Properties
    private lazy var scrollView: SimpleScrollView = {
        let element = SimpleScrollView(spacing: 32,
                                       margins: .init(top: 32, leading: 32, bottom: 32, trailing: 32))
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var productDetailStackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .vertical
        element.spacing = 8
        element.distribution = .fill
        return element
    }()

    private lazy var nameLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .nunito(style: .semiBold, size: 20)
        element.textColor = .black
        element.numberOfLines = 0
        element.textAlignment = .left
        return element
    }()

    private lazy var photoImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.masksToBounds = true
        element.contentMode = .scaleAspectFill
        element.layer.cornerRadius = 5
        return element
    }()
    
    private lazy var priceStackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .horizontal
        element.spacing = 8
        element.distribution = .fill
        return element
    }()

    private lazy var priceLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .nunito(style: .bold, size: 20)
        element.textColor = .black
        element.numberOfLines = 0
        element.textAlignment = .left
        return element
    }()

    private lazy var shareButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
        element.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        return element
    }()

    private lazy var descriptionTitleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .nunito(style: .medium, size: 18)
        element.textColor = .black
        element.numberOfLines = 0
        element.textAlignment = .left
        element.text = "descrição"
        return element
    }()

    private lazy var descriptionValueLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .nunito(style: .regular, size: 16)
        element.textColor = .black
        element.numberOfLines = 0
        element.textAlignment = .left
        return element
    }()

    private lazy var addToCartButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapAddToCart), for: .touchUpInside)
        element.tintColor = .black
        element.setTitle("adicionar a sacolinha", for: .normal)
        element.setTitleColor(.black, for: .normal)
        element.configuration = .makeWith(backgroundColor: UIColor(rgb: 0xFFC13B),
                                          font: .nunito(style: .medium, size: 18))
        element.layer.cornerRadius = 5
        return element
    }()
    
    private lazy var detailsView: InfoDataView = {
        let element = InfoDataView(title: "detalhes", infos: [])
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var sellerView: SellerView = {
        let element = SellerView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    // MARK: - Inits
    init() {
        super.init()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
        
    // MARK: Actions
    
    @objc
    private func didTapAddToCart() {
        delegate?.didTapAddToCart()
    }
    
    @objc
    private func didTapShare() {
        delegate?.didTapShare()
    }

    // MARK: - Public Methods
    
    func set(product: ProductResponse) {
        DispatchQueue.main.async { [weak self] in
            self?.updateProductData(product: product)
            self?.updateDetailsView(product: product)
            self?.updateSellerView(product: product)
        }
    }
    
    // MARK: Private Methods
    private func updateProductData(product: ProductResponse) {
        nameLabel.text = product.name
        photoImageView.addImageFromURL(urlString: product.image ?? "")
        priceLabel.text = product.price
        descriptionValueLabel.text = product.description
    }
    
    private func updateDetailsView(product: ProductResponse) {
        detailsView.updateData(
            infos: [
                ("tamanho", product.size ?? ""),
                ("condição", product.condition ?? ""),
                ("marca", product.brand ?? "")
            ],
            footerTitle: "outras informações",
            footerMessage: product.otherInfos
        )
    }
    
    private func updateSellerView(product: ProductResponse) {
        sellerView.updateData(name: product.seller?.name ?? "",
                              memberSince: product.seller?.memberSince ?? "",
                              sales: "\(product.seller?.sales ?? 0) vendas")
    }
}

// MARK: - Overriding ViewCodable
extension ProductDetailView {
    override public func buildViewHierarchy() {
        super.buildViewHierarchy()
        
        productDetailStackView.addArrangedSubview(nameLabel)
        productDetailStackView.addArrangedSubview(photoImageView)
        productDetailStackView.addArrangedSubview(priceStackView)
        priceStackView.addArrangedSubview(priceLabel)
        priceStackView.addArrangedSubview(shareButton)
        productDetailStackView.addArrangedSubview(descriptionTitleLabel)
        productDetailStackView.addArrangedSubview(descriptionValueLabel)
        
        scrollView.addSubview(productDetailStackView)
        scrollView.addSubview(addToCartButton)
        scrollView.addSubview(detailsView)
        scrollView.addSubview(sellerView)
        
        addSubview(scrollView)
    }

    override public func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topYellowBarView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            photoImageView.heightAnchor.constraint(equalToConstant: 300),
            shareButton.heightAnchor.constraint(equalToConstant: 30),
            shareButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }

    override public func setupAdditionalConfiguration() {
        super.setupAdditionalConfiguration()
        scrollView.addCustomSpace(spacing: 72, afterView: productDetailStackView)
    }
}
