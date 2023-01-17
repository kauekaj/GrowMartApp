//
//  CatalogViewModel.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 16/01/23.
//

import Foundation

struct ProductForCatalog {
    var id: String?
    let name: String?
    let image: String?
    let price: String?
}

protocol CatalogViewModelDelegate: AnyObject {
    func bindProductsUpdated()
    func bindFavoritesUpdated()
}

final class CatalogViewModel {
    
    weak var delegate: CatalogViewModelDelegate?
    
    private lazy var networkManager = NetworkManager(router: Router())
    
    private var products = [ProductForCatalog]() {
        didSet {
            delegate?.bindProductsUpdated()
//            bindProductsUpdated()
        }
    }
    
    private var favorites = [Favorite]() {
        didSet {
            delegate?.bindFavoritesUpdated()
//            bindFavoritesUpdated()
        }
    }
    
    var bindProductsUpdated: (() -> Void) = {}
    var bindFavoritesUpdated: (() -> Void) = {}
    
    // MARK: - Inits
    
    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(favoritesUpdatedNotification),
                                               name: Notification.Name("FavoritesUpdated"),
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name("FavoritesUpdated"),
                                                  object: nil)
    }
    
    // MARK: - Public Methods
    
    func loadData() {
        loadFavorites()
        callService()
    }
    
    func getNumberOfItems() -> Int {
        products.count
    }
    
    func getProduct(at index: Int) -> ProductForCatalog? {
        guard index < products.count else {
            return nil
        }
        
        return products[index]
    }
    
    func isFavorite(id: String) -> Bool {
        favorites.compactMap { $0.identifier }.contains(id)
    }
    
    func addFavorite(id: String) {
        guard let product = products.first(where: { $0.id == id }) else {
            return
        }
        
        DataManager.shared.addFavorite(.init(id: product.id,
                                             name: product.name,
                                             image: product.image,
                                             price: product.price))
    }
    
    func removeFavorite(id: String) {
        DataManager.shared.removeFavorite(id: id)
    }
    
    // MARK: - Private Methods
    
    @objc
    func favoritesUpdatedNotification(_ notification: NSNotification) {
        if let favorites = notification.userInfo?["favorites"] as? [Favorite] {
            self.favorites = favorites
        } else {
            loadFavorites()
        }
    }
    
    private func loadFavorites() {
        favorites = DataManager.shared.loadFavorites()
    }
    
    private func callService() {
        networkManager.execute(endpoint: ProductsApi.list(page: 1)) { [weak self] (response: Result<ProductsResponse, NetworkResponse>) in
            guard let safeSelf = self else { return }
            
            switch response {
            case let .success(data):
                guard let products = data.entries else {
                    // Apresentar estado de erro
                    return
                }
                
                let productsForCatalog = products.map { item in
                    ProductForCatalog(id: item.id,
                                      name: item.name,
                                      image: item.image,
                                      price: item.price)
                }
                
                safeSelf.products.append(contentsOf: productsForCatalog)
            case .failure:
                // Apresentar estado de erro
                break
            }
        }
    }
}
