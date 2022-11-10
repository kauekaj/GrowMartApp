//
//  FavoritesViewController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 04/11/22.
//

import UIKit
import CoreData
import RealmSwift

class FavoritesViewController: BaseViewController {
    // MARK: - Private Properties
    private lazy var favoritesView: FavoritesView = {
        let element = FavoritesView()
        element.delegate = self
        return element
    }()
    
    private lazy var realm = try! Realm()
    
    var favoritesFromCoreData = [Favorite]() {
        didSet {
            favoritesView.reloadData()
        }
    }
    
    var favoritesFromRealm = [RealmFavorite]() {
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
            loadFavoritesFromCoreData()
            loadFavoritesFromRealm()
        }
        
        private func loadFavoritesFromCoreData() {
            let favoritesFetch: NSFetchRequest<Favorite> = Favorite.fetchRequest()
            let sortById = NSSortDescriptor(key: #keyPath(Favorite.identifier), ascending: false)
            favoritesFetch.sortDescriptors = [sortById]
            
            // Explanation: https://stackoverflow.com/questions/7304257/coredata-error-data-fault
            favoritesFetch.returnsObjectsAsFaults = false

            do {
                let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
                let results = try managedContext.fetch(favoritesFetch)
                favoritesFromCoreData = results
            } catch let error as NSError {
                print("Fetch error: \(error) description: \(error.userInfo)")
            }
        }
        
        func loadFavoritesFromRealm() {
            favoritesFromRealm = realm.objects(RealmFavorite.self).map { $0 }
        }
}

// MARK: - CatalogViewDelegate
extension FavoritesViewController: FavoritesViewDelegate {
    func numberOfItems() -> Int {
        favoritesFromRealm.count
    }
    
    func getFavorite(at index: Int) -> RealmFavorite? {
        guard index < favoritesFromRealm.count else {
            return nil
        }

        return favoritesFromRealm[index]
    }
        
    func didTapFavorite(at index: Int) {
        navigationController?.pushViewController(ProductDetailViewController(), animated: true)
    }
    
    func didTapRemove(id: String) {
        removeFavoriteFromCoreData(id: id)
        removeFavoriteFromRealm(id: id)
        favoritesView.reloadData()
        
        NotificationCenter.default.post(name: Notification.Name("FavoritesUpdated"), object: nil)
    }
    
    private func removeFavoriteFromCoreData(id: String) {
        guard let index = favoritesFromCoreData.firstIndex(where: { $0.identifier == id }) else {
            return
        }

        AppDelegate.sharedAppDelegate.coreDataStack.managedContext.delete(favoritesFromCoreData[index])
        favoritesFromCoreData.remove(at: index)
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
    }
    
    private func removeFavoriteFromRealm(id: String) {
        guard let index = favoritesFromRealm.firstIndex(where: { $0.identifier == id }) else {
            return
        }

        try! realm.write {
            let favoriteToDelete = favoritesFromRealm[index]
            realm.delete(favoriteToDelete)
            favoritesFromRealm.remove(at: index)
        }
    }
}
