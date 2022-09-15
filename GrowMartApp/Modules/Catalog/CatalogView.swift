//
//  CatalogView.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 10/09/22.
//

import UIKit

public protocol CatalogViewDelegate: AnyObject {
       func numberOfItems() -> Int
       func getProduct(at index: Int) -> Product?

       func didTapButtonClothes()
       func didTapButtonAcessories()
       func didTapButtonOthers()
       func didTapProduct(at index: Int)
}

class CatalogView: UIView {
    
    // MARK: - Public Properties
    weak var delegate: CatalogViewDelegate?
    
    // MARK: - Private Properties
    
    private lazy var searchTextField: SearchTextField = {
        let element = SearchTextField()
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
        element.image = UIImage(named: "bannerImage")
        return element
    }()
    
    private lazy var categoriesSegmented: CategoriesSegmentedControl = {
        let element = CategoriesSegmentedControl(items: ["roupas", "acessórios", "outros"])
        element.translatesAutoresizingMaskIntoConstraints = false
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

    // MARK: - Inits

    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    public func reloadData() {
        collectionView.reloadData()
    }
    
}

extension CatalogView: ViewCodable {
    
    public func buildViewHierarchy() {
        addSubview(searchTextField)
        addSubview(bannerImageView)
        addSubview(categoriesSegmented)
        addSubview(collectionView)
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
            
            categoriesSegmented.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 32),
            categoriesSegmented.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            categoriesSegmented.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            categoriesSegmented.heightAnchor.constraint(equalToConstant: 45),
            
            collectionView.topAnchor.constraint(equalTo: categoriesSegmented.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    public func setupAdditionalConfiguration() {
        backgroundColor = .white

        //bannerImageView.addImageFromURL(urlString: "https://www.designi.com.br/images/preview/10236255.jpg")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collectionView.register(CatalogItemCell.self, forCellWithReuseIdentifier: CatalogItemCell.identifier)
    }
}

extension CatalogView: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        delegate?.numberOfItems() ?? 0

    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let product = delegate?.getProduct(at: indexPath.row),
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogItemCell.identifier, for: indexPath) as? CatalogItemCell else {
            return UICollectionViewCell()
        }

        cell.setup(with: product)
        return cell
       
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapProduct(at: indexPath.row)
    }
}
