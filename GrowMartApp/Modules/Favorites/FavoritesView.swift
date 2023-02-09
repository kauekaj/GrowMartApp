//
//  FavoritesView.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 04/11/22.
//

import UIKit

protocol FavoritesViewDelegate: AnyObject {
    func numberOfItems() -> Int
    func getFavorite(at index: Int) -> Favorite?
    
    func didTapFavorite(at index: Int)
    func didTapRemove(id: String)
}

public class FavoritesView: BaseView {
    // MARK: - Public Properties
    weak var delegate: FavoritesViewDelegate?
    
    // MARK: - Private Properties
    private lazy var headerView: HeaderView = {
        let element = HeaderView(title: "favoritos",
                                 icon: .makeWith(systemImage: .starFill, color: Asset.Colors.lightRed.color),
                                 roundedIcon: false)
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
        super.init()
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
}

extension FavoritesView {
    public override func buildViewHierarchy() {
        super.buildViewHierarchy()
        addSubview(headerView)
        addSubview(collectionView)
    }

    public override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topYellowBarView.bottomAnchor, constant: 24),
            headerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            headerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),

            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    public override func setupAdditionalConfiguration() {
        super.setupAdditionalConfiguration()
        backgroundColor = .white

        collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.reuseIdentifier)
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension FavoritesView: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        delegate?.numberOfItems() ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let favorite = delegate?.getFavorite(at: indexPath.row),
              let cell: FavoriteCell = .createCell(for: collectionView, at: indexPath) else {
            return UICollectionViewCell()
        }

        cell.setup(with: favorite)
        cell.delegate = self
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapFavorite(at: indexPath.row)
    }
}

// MARK: - FavoriteCellDelegate
extension FavoritesView: FavoriteCellDelegate {
    func didTapRemove(id: String) {
        delegate?.didTapRemove(id: id)
    }
}
