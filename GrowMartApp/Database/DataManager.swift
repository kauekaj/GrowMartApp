//
//  DataManager.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 16/11/22.
//

import Foundation
import CoreData
import RealmSwift

enum DatabaseSource {
    case coreData
    case realm
}

enum DataManagerKey: String {
    case userID = "UserID"
    case userName = "UserName"
    case userEmail = "UserEmail"
    case userPhone = "UserPhone"
    case user = "User"
}

class DataManager {
    // MARK: Private Properties
    private var source: DatabaseSource = .coreData
    private lazy var realm = try! Realm()

    // MARK: Public Properties
    
    static let shared = DataManager()

    // MARK: Init
    
    private init() {}
    
    // MARK: Public Methods
    func setupDatabaseSource(_ source: DatabaseSource) {
        self.source = source
    }

    func saveString(key: DataManagerKey, value: String?, isSecure: Bool = false) {
        if isSecure {
            saveStringKeyChain(key: key, value: value ?? "")
        } else {
            saveStringUserDefaults(key: key, value: value ?? "")
        }
    }
    
    func getString(key: DataManagerKey, isSecure: Bool = false) -> String? {
        isSecure ? getStringKeyChain(key: key) : getStringUserDefaults(key: key)
    }
    
    func saveInt(key: DataManagerKey, value: Int?, isSecure: Bool = false) {
        if isSecure {
            saveIntKeyChain(key: key, value: value ?? 0)
        } else {
            saveIntUserDefaults(key: key, value: value ?? 0)
        }
    }
    
    func getInt(key: DataManagerKey, isSecure: Bool = false) -> Int? {
        isSecure ? getIntKeyChain(key: key) : getIntUserDefaults(key: key)
    }
    
    func saveObject<T: Codable>(key: DataManagerKey, value: T?, isSecure: Bool = false) {
        if isSecure {
            saveObjectKeyChain(key: key, value: value)
        } else {
            saveObjectUserDefaults(key: key, value: value)
        }
    }
    
    func getObject<T: Codable>(key: DataManagerKey, isSecure: Bool = false) -> T? {
        isSecure ? getObjectKeyChain(key: key) : getObjectUserDefaults(key: key)
    }
    
    func loadFavorites() -> [Favorite] {
        switch source {
        case .coreData:
            return loadFavoritesFromCoreData()
        case .realm:
            return loadFavoritesFromRealm()
        }
    }
    
    func addFavorite(_ product: ProductResponse) {
        switch source {
        case .coreData:
            addFavoriteToCoreData(product)
        case .realm:
            addFavoriteToRealm(product)
        }
    }
    
    func removeFavorite(id: String) {
        switch source {
        case .coreData:
            removeFavoriteFromCoreData(id: id)
        case .realm:
            removeFavoriteFromRealm(id: id)
        }
    }
}

// MARK: Private Methods (Realm)

extension DataManager {
    private func loadFavoritesFromRealm() -> [Favorite] {
        realm.objects(RealmFavorite.self).compactMap { item in
            Favorite(identifier: item.identifier,
                     image: item.image,
                     name: item.name,
                     price: item.price)
        }
    }

    private func addFavoriteToRealm(_ product: ProductResponse) {
        try! realm.write {
            realm.add(RealmFavorite(identifier: product.id,
                                    image: product.image,
                                    name: product.name,
                                    price: product.price))
        }
    }

    private func removeFavoriteFromRealm(id: String) {
        try! realm.write {
            let favoriteToDelete = realm.objects(RealmFavorite.self).where { $0.identifier == id }
            realm.delete(favoriteToDelete)
        }
    }
}

// MARK: Private Methods (CoreData)

extension DataManager {
    private func getFavoritesFromCoreData() -> [CoreDataFavorite] {
        let favoritesFetch: NSFetchRequest<CoreDataFavorite> = CoreDataFavorite.fetchRequest()
        let sortById = NSSortDescriptor(key: #keyPath(CoreDataFavorite.identifier), ascending: false)
        favoritesFetch.sortDescriptors = [sortById]

        // Explanation: https://stackoverflow.com/questions/7304257/coredata-error-data-fault
        favoritesFetch.returnsObjectsAsFaults = false

        do {
            let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            return try managedContext.fetch(favoritesFetch)
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
            return []
        }
    }

    private func loadFavoritesFromCoreData() -> [Favorite] {
        getFavoritesFromCoreData().compactMap { item in
            Favorite(identifier: item.identifier,
                     image: item.image,
                     name: item.name,
                     price: item.price)
        }
    }

    private func addFavoriteToCoreData(_ product: ProductResponse) {
        var favorites = getFavoritesFromCoreData()

        let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        let newFavorite = CoreDataFavorite(context: managedContext)
        newFavorite.setValue(product.id, forKey: #keyPath(CoreDataFavorite.identifier))
        newFavorite.setValue(product.image, forKey: #keyPath(CoreDataFavorite.image))
        newFavorite.setValue(product.name, forKey: #keyPath(CoreDataFavorite.name))
        newFavorite.setValue(product.price, forKey: #keyPath(CoreDataFavorite.price))

        favorites.insert(newFavorite, at: 0)
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
    }

    private func removeFavoriteFromCoreData(id: String) {
        let favorites = getFavoritesFromCoreData()

        guard let index = favorites.firstIndex(where: { $0.identifier == id }) else {
            return
        }

        AppDelegate.sharedAppDelegate.coreDataStack.managedContext.delete(favorites[index])
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
    }
}

// MARK: Private Methods (UserDefaults)

extension DataManager {
    private func saveStringUserDefaults(key: DataManagerKey, value: String) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    private func getStringUserDefaults(key: DataManagerKey) -> String? {
        UserDefaults.standard.string(forKey: key.rawValue)
    }
    
    private func saveIntUserDefaults(key: DataManagerKey, value: Int) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    private func getIntUserDefaults(key: DataManagerKey) -> Int? {
        UserDefaults.standard.integer(forKey: key.rawValue)
    }
    
    private func saveObjectUserDefaults<T: Codable>(key: DataManagerKey, value: T) {
        if let encoded = try? JSONEncoder().encode(value) {
            UserDefaults.standard.set(encoded, forKey: key.rawValue)
        }
    }
    
    private func getObjectUserDefaults<T: Codable>(key: DataManagerKey) -> T? {
        guard let data = UserDefaults.standard.object(forKey: key.rawValue) as? Data,
              let object = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        
        return object
    }
}

// MARK: Private Methods (KeyChain)

extension DataManager {
    private func saveStringKeyChain(key: DataManagerKey, value: String) {
        KeychainWrapper.standard.set(value, forKey: key.rawValue)
    }
    
    private func getStringKeyChain(key: DataManagerKey) -> String? {
        KeychainWrapper.standard.string(forKey: key.rawValue)
    }
    
    private func saveIntKeyChain(key: DataManagerKey, value: Int) {
        KeychainWrapper.standard.set(value, forKey: key.rawValue)
    }
    
    private func getIntKeyChain(key: DataManagerKey) -> Int? {
        KeychainWrapper.standard.integer(forKey: key.rawValue)
    }
    
    private func saveObjectKeyChain<T: Codable>(key: DataManagerKey, value: T) {
        if let encoded = try? JSONEncoder().encode(value) {
            KeychainWrapper.standard.set(encoded, forKey: key.rawValue)
        }
    }
    
    private func getObjectKeyChain<T: Codable>(key: DataManagerKey) -> T? {
        guard let data = KeychainWrapper.standard.data(forKey: key.rawValue),
              let object = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        
        return object
    }
}
