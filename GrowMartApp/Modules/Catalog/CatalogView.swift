//
//  CatalogView.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 10/09/22.
//

import UIKit

protocol CatalogViewDelegate: AnyObject {
    func numberOfItems() -> Int
    func getProduct(at index: Int) -> ProductResponse?

    func didTapProduct(at index: Int)
    func didSelectCategory(index: Int, name: String)
    func didTapFilterButton()
    func isFavorite(id: String) -> Bool
    func didTapFavorite(id: String, isFavorite: Bool)
}

public class CatalogView: UIView {
    // MARK: - Public Properties
    weak var delegate: CatalogViewDelegate?
    
    private let categories = ["roupas", "acessórios", "outros"]

    // MARK: - Private Properties
    private lazy var searchTextField: RightIconTextField = {
        let element = RightIconTextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.placeholder = "buscar"
        element.borderStyle = .roundedRect
        element.layer.cornerRadius = 5
        element.font = .nunito(style: .regular, size: 18)
        element.rightView = UIImageView(image: UIImage(named: "search"))
        element.rightViewMode = .always
        return element
    }()
    
    private lazy var bannerImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.masksToBounds = true
        element.contentMode = .scaleAspectFill
        element.isUserInteractionEnabled = true
        element.layer.cornerRadius = 5
        element.backgroundColor = .lightGray
        return element
    }()
    
    private lazy var closeBannerButton: UIButton = {
        let element = UIButton(type: .custom)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapCloseBannerButton), for: .touchUpInside)
        element.setImage(.makeWith(systemImage: .xmark, color: .white), for: .normal)
        return element
    }()

    private lazy var categoriesSegmented: CategoriesSegmentedControl = {
        let element = CategoriesSegmentedControl(items: categories)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
        return element
    }()
    
    private lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.sectionInset = .init(top: 32, left: 0, bottom: 16, right: 0)
        let spacesBetweenItens: CGFloat = 80
        viewLayout.itemSize = .init(width: (UIScreen.main.bounds.width - spacesBetweenItens) / 2, height: 230)
        viewLayout.minimumInteritemSpacing = 16
        viewLayout.minimumLineSpacing = 16

        let element = UICollectionView(frame: .zero,
                                       collectionViewLayout: viewLayout)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.showsVerticalScrollIndicator = false
        element.delegate = self
        element.dataSource = self
        return element
    }()
    
    private lazy var filterButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.cornerRadius = 5
        element.addTarget(self, action: #selector(didTapFilterButton), for: .touchUpInside)
        element.configuration = .makeWith(backgroundColor: .init(rgb: 0xFFC13B),
                                          title: "filtros",
                                          font: .nunito(style: .semiBold, size: 18),
                                          icon: .makeWith(systemImage: .sliderHorizontal3, color: .white),
                                          imagePlacement: .trailing)
        return element
    }()

    // MARK: - Inits
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    public func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    // MARK: - Actions
    @objc func segmentedValueChanged() {
        let index = categoriesSegmented.selectedSegmentIndex
        delegate?.didSelectCategory(index: index, name: categories[index])
    }
    
    @objc
    func didTapFilterButton() {
        delegate?.didTapFilterButton()
    }
    
    @objc
    func didTapCloseBannerButton() {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
            self.bannerImageView.alpha = 0.0
        }, completion: { _ in
            self.bannerImageView.removeFromSuperview()
            self.categoriesSegmented.topAnchor.constraint(equalTo: self.searchTextField.bottomAnchor,
                                                          constant: 32).isActive = true
        })
    }
}

extension CatalogView: ViewCodable {
    public func buildViewHierarchy() {
        addSubview(searchTextField)
        addSubview(bannerImageView)
        bannerImageView.addSubview(closeBannerButton)
        addSubview(categoriesSegmented)
        addSubview(collectionView)
        addSubview(filterButton)
    }

    public func setupConstraints() {
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            searchTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            searchTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            searchTextField.heightAnchor.constraint(equalToConstant: 45),
            
            bannerImageView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 32),
            bannerImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            bannerImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            bannerImageView.heightAnchor.constraint(equalToConstant: 150),
            
            closeBannerButton.heightAnchor.constraint(equalToConstant: 40),
            closeBannerButton.widthAnchor.constraint(equalToConstant: 40),
            closeBannerButton.topAnchor.constraint(equalTo: bannerImageView.topAnchor),
            closeBannerButton.trailingAnchor.constraint(equalTo: bannerImageView.trailingAnchor),

            categoriesSegmented.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 32),
            categoriesSegmented.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            categoriesSegmented.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            categoriesSegmented.heightAnchor.constraint(equalToConstant: 45),
            
            collectionView.topAnchor.constraint(equalTo: categoriesSegmented.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            filterButton.heightAnchor.constraint(equalToConstant: 40),
            filterButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            filterButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }

    public func setupAdditionalConfiguration() {
        backgroundColor = .white
        
        bannerImageView.addImageFromURL(urlString: "https://www.designi.com.br/images/preview/10236255.jpg")
        collectionView.register(CatalogItemCell.self, forCellWithReuseIdentifier: CatalogItemCell.reuseIdentifier)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension CatalogView: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        delegate?.numberOfItems() ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let product = delegate?.getProduct(at: indexPath.row),
              let cell: CatalogItemCell = .createCell(for: collectionView, at: indexPath) else {
            return UICollectionViewCell()
        }

        var isFavorite = false
        if let id = product.id,
           let value = delegate?.isFavorite(id: id) {
            isFavorite = value
        }
        
        cell.setup(with: product, isFavorite: isFavorite)
        cell.delegate = self
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapProduct(at: indexPath.row)
    }
}

// MARK: - CatalogItemCellDelegate
extension CatalogView: CatalogItemCellDelegate {
    func didTapFavorite(id: String, isFavorite: Bool) {
        delegate?.didTapFavorite(id: id, isFavorite: isFavorite)
    }
}
