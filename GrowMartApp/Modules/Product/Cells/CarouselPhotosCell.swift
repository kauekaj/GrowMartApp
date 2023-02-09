//
//  CarouselPhotosCell.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 03/10/22.
//

import UIKit

public protocol CarouselPhotosCellDelegate: AnyObject {
    func didTapAddPhotoButton()
    func didTapPhoto(at index: Int)
}

public final class CarouselPhotosCell: UITableViewCell {
    
    // MARK: Public Properties
    public weak var delegate: CarouselPhotosCellDelegate?

    // MARK: Private Properties
    
    private var photos: [Photo] = [] {
        didSet {
            button.isHidden = !photos.isEmpty
            collectionView.reloadData()
        }
    }
    
    private lazy var button: UIControl = {
        let element = UIControl()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.isUserInteractionEnabled = true
        element.layer.cornerRadius = 5
        element.layer.borderColor = Asset.Colors.lightRed.color.cgColor
        element.layer.borderWidth = 1
        element.backgroundColor = Asset.Colors.lightGray.color
        element.addTarget(self, action: #selector(didTapAddPhotoButton(_:)), for: .touchUpInside)
        return element
    }()
    
    private lazy var addPhotoLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = FontFamily.Nunito.medium.font(size: 20)
        element.textColor = Asset.Colors.lightRed.color
        element.numberOfLines = 1
        element.textAlignment = .center
        element.text = "adicionar foto"
        element.isUserInteractionEnabled = false
        return element
    }()
    
    private lazy var addPhotoIcon: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = .init(named: "add-photo")
        element.tintColor = Asset.Colors.lightRed.color
        element.isUserInteractionEnabled = false
        return element
    }()
    
    private lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        let spacesBetweenItens: CGFloat = 80
        viewLayout.itemSize = .init(width: (UIScreen.main.bounds.width - spacesBetweenItens) / 2, height: 150)
        viewLayout.minimumInteritemSpacing = 16
        viewLayout.scrollDirection = .horizontal

        let element = UICollectionView(frame: .zero,
                                       collectionViewLayout: viewLayout)
        element.isUserInteractionEnabled = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.showsHorizontalScrollIndicator = false
        element.delegate = self
        element.dataSource = self
        return element
    }()
    
    // MARK: Actions
    
    @objc
    private func didTapAddPhotoButton(_ sender: Any) {
        delegate?.didTapAddPhotoButton()
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
    public func setPhotos(photos: [Photo]) {
        self.photos = photos
    }
    
    // MARK: - Private Methods
    private func totalCells() -> Int {
        photos.count + 1
    }
}

extension CarouselPhotosCell: ViewCodable {
    public func buildViewHierarchy() {
        contentView.addSubview(collectionView)
        contentView.addSubview(button)
        button.addSubview(addPhotoIcon)
        button.addSubview(addPhotoLabel)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 150),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.heightAnchor.constraint(equalToConstant: 150),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            
            addPhotoIcon.widthAnchor.constraint(equalToConstant: 25),
            addPhotoIcon.heightAnchor.constraint(equalToConstant: 25),
            addPhotoIcon.topAnchor.constraint(equalTo: button.topAnchor, constant: 48),
            addPhotoIcon.centerXAnchor.constraint(equalTo: button.centerXAnchor),

            addPhotoLabel.topAnchor.constraint(equalTo: addPhotoIcon.bottomAnchor, constant: 4),
            addPhotoLabel.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            addPhotoLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor)
        ])
    }
    
    public func setupAdditionalConfiguration() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collectionView.register(AddPhotoCell.self, forCellWithReuseIdentifier: AddPhotoCell.reuseIdentifier)
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension CarouselPhotosCell: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalCells()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard totalCells() > indexPath.row else {
            return UICollectionViewCell()
        }
        
        if indexPath.row == totalCells() - 1, let cell: AddPhotoCell = .createCell(for: collectionView, at: indexPath) {
            return cell
        }
                
        if let cell: PhotoCell = .createCell(for: collectionView, at: indexPath) {
            cell.setup(with: photos[indexPath.row])
            return cell
        }

        return UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == totalCells() - 1 {
            delegate?.didTapAddPhotoButton()
        } else {
            delegate?.didTapPhoto(at: indexPath.row)
        }
    }
}
