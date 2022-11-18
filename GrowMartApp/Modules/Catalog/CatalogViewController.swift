//
//  CatalogViewController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 14/09/22.
//

import UIKit

class CatalogViewController: BaseViewController {
    
    // MARK: - Private Properties
    private lazy var catalogView: CatalogView = {
        let element = CatalogView()
        element.delegate = self
        return element
    }()
    
    private lazy var networkManager = NetworkManager(router: Router())
    private var products = [ProductResponse]()
    private var favorites = [Favorite]()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        addCartButton()
        loadFavorites()
        callService()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(favoritesUpdated),
                                               name: Notification.Name("FavoritesUpdated"),
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func loadView() {
        super.loadView()
        view = catalogView
    }
    
    // MARK: - Private Methods
    
    @objc
    func favoritesUpdated() {
        loadFavorites()
        catalogView.reloadData()
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
                
                safeSelf.products.append(contentsOf: products)
                safeSelf.catalogView.reloadData()
            case .failure:
                // Apresentar estado de erro
                break
            }
        }
    }
    
    private func addFavorite(id: String) {
        guard let product = products.first(where: { $0.id == id }) else {
            return
        }
        
        DataManager.shared.addFavorite(product)
    }
    
    private func removeFavorite(id: String) {
        DataManager.shared.removeFavorite(id: id)
    }
    
}
    // MARK: - CatalogViewDelegate

    extension CatalogViewController: CatalogViewDelegate {
        func didTapFavorite(id: String, isFavorite: Bool) {
            if isFavorite {
                addFavorite(id: id)
            } else {
                removeFavorite(id: id)
            }
        }
        
        func numberOfItems() -> Int {
            products.count
        }
        
        func getProduct(at index: Int) -> ProductResponse? {
            guard index < products.count else {
                return nil
            }
            
            return products[index]
        }
        
        func didSelectCategory(index: Int, name: String) {
            catalogView.reloadData()
        }
        
        func didTapProduct(at index: Int) {
            navigationController?.pushViewController(ProductDetailViewController(), animated: true)
        }
        
        func isFavorite(id: String) -> Bool {
            favorites.compactMap { $0.identifier }.contains(id)
        }
        
        func didTapFilterButton() {
            print("didTapFilterButton")
        }
    }
