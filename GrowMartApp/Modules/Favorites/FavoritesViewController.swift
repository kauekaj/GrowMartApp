//
//  FavoritesViewController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 04/11/22.
//

import UIKit
import CoreData

class FavoritesViewController: BaseViewController {
    // MARK: - Private Properties
    private lazy var favoritesView: FavoritesView = {
        let element = FavoritesView()
        element.delegate = self
        return element
    }()
    
    var favorites = [Favorite]() {
        didSet {
            favoritesView.reloadData()
        }
    }

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        loadFavorites()
    }
    
    override func loadView() {
        super.loadView()
        view = favoritesView
    }
    
    // MARK: - Private Methods
    private func loadFavorites() {
        let favoritesFetch: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        let sortById = NSSortDescriptor(key: #keyPath(Favorite.identifier), ascending: false)
        favoritesFetch.sortDescriptors = [sortById]
        
        // Explanation: https://stackoverflow.com/questions/7304257/coredata-error-data-fault
        favoritesFetch.returnsObjectsAsFaults = false

        do {
            let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let results = try managedContext.fetch(favoritesFetch)
            favorites = results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
}

// MARK: - CatalogViewDelegate
extension FavoritesViewController: FavoritesViewDelegate {
    func numberOfItems() -> Int {
        favorites.count
    }
    
    func getFavorite(at index: Int) -> Favorite? {
        guard index < favorites.count else {
            return nil
        }

        return favorites[index]
    }
        
    func didTapFavorite(at index: Int) {
        navigationController?.pushViewController(ProductDetailViewController(), animated: true)
    }
    
    func didTapRemove(id: String) {
        guard let index = favorites.firstIndex(where: { $0.identifier == id }) else {
            return
        }

        AppDelegate.sharedAppDelegate.coreDataStack.managedContext.delete(favorites[index])
        favorites.remove(at: index)
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
        favoritesView.reloadData()
    }
}
