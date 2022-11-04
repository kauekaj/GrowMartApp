//
//  CatalogViewController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 14/09/22.
//

import UIKit
import CoreData

class CatalogViewController: BaseViewController {
    // MARK: - Private Properties
    private lazy var catalogView: CatalogView = {
        let element = CatalogView()
        element.delegate = self
        return element
    }()
    
    private lazy var networkManager = NetworkManager(router: Router())
    private var products = [ProductResponse]()
//    private var favorites = [Favorite]()

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        addCartButton()
//        loadFavorites()
        callService()
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
    
//    private func loadFavorites() {
//        let favoritesFetch: NSFetchRequest<Favorite> = Favorite.fetchRequest()
//        let sortById = NSSortDescriptor(key: #keyPath(Favorite.identifier), ascending: false)
//        favoritesFetch.sortDescriptors = [sortById]
//
//        // Explanation: https://stackoverflow.com/questions/7304257/coredata-error-data-fault
//        favoritesFetch.returnsObjectsAsFaults = false
//
//        do {
//            let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
//            let results = try managedContext.fetch(favoritesFetch)
//            favorites = results
//        } catch let error as NSError {
//            print("Fetch error: \(error) description: \(error.userInfo)")
//        }
//    }

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
//
//    private func addFavorite(id: String) {
//        guard let product = products.first(where: { $0.id == id }) else {
//            return
//        }
//
//        let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
//        let newFavorite = Favorite(context: managedContext)
//        newFavorite.setValue(product.id, forKey: #keyPath(Favorite.identifier))
//        newFavorite.setValue(product.image, forKey: #keyPath(Favorite.image))
//        newFavorite.setValue(product.name, forKey: #keyPath(Favorite.name))
//        newFavorite.setValue(product.price, forKey: #keyPath(Favorite.price))
//
//        favorites.insert(newFavorite, at: 0)
//        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
//    }

//    private func removeFavorite(id: String) {
//        guard let index = favorites.firstIndex(where: { $0.identifier == id }) else {
//            return
//        }
//
//        AppDelegate.sharedAppDelegate.coreDataStack.managedContext.delete(favorites[index])
//        favorites.remove(at: index)
//        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
//    }
}

// MARK: - CatalogViewDelegate
extension CatalogViewController: CatalogViewDelegate {
    func didTapFavorite(id: String, isFavorite: Bool) {
//        if isFavorite {
//            addFavorite(id: id)
//        } else {
//            removeFavorite(id: id)
//        }
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
//        favorites.compactMap { $0.identifier }.contains(id)
        false
    }
    
    func didTapFilterButton() {
        print("didTapFilterButton")
    }
}
