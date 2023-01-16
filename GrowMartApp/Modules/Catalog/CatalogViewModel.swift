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

final class CatalogViewModel {
    
    private lazy var networkManager = NetworkManager(router: Router())
    
    private var products = [ProductForCatalog]() {
        didSet {
            bindProductsUpdated()
        }
    }
    
    private var favorites = [Favorite]() {
        didSet {
            bindFavoritesUpdated()
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
        networkManager.execute(endpoint: ProductsApi.list(page: 1)) { [weak self] (response: Result<ProductForCatalog, NetworkResponse>) in
            guard let safeSelf = self else { return }
            
            switch response {
            case let .success(data):
                guard let products = data.entries else {
                    // Apresentar estado de erro
                    return
                }
                
                safeSelf.products.append(contentsOf: products)
//                safeSelf.bindProductsUpdated()
            case .failure:
                // Apresentar estado de erro
                break
            }
        }
    }
}
