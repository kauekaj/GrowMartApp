//
//  DataManager.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 16/11/22.
//

import Foundation
import CoreData
import RealmSwift
import FirebaseDatabase

enum DatabaseSource {
    case coreData
    case realm
    case realtimeDatabase
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
    private var userDefaults: UserDefaultsActions = UserDefaults.standard
    private var keychain: KeychainActions = KeychainWrapper.standard
    private var coreDataStack: CoreDataStack = AppDelegate.sharedAppDelegate.coreDataStack
    private var realtimeDatabase = Database.database().reference()
    private var realm: Realm?
    
    // MARK: Public Properties
    
    static let shared = DataManager()
    
    // MARK: Init
    
    private init() {}
    
    // MARK: Public Methods
    func setup(source: DatabaseSource = .coreData,
               realm: Realm? = try! Realm(),
               coreDataStack: CoreDataStack = AppDelegate.sharedAppDelegate.coreDataStack,
               userDefaults: UserDefaultsActions = UserDefaults.standard,
               keychain: KeychainActions = KeychainWrapper.standard) {
        self.source = source
        self.realm = realm
        self.coreDataStack = coreDataStack
        self.userDefaults = userDefaults
        self.keychain = keychain
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
        case .realtimeDatabase:
            loadFavoritesFromRealtimeDatabse()
            return []
        }
    }
    
    func addFavorite(_ product: ProductResponse) {
        switch source {
        case .coreData:
            addFavoriteToCoreData(product)
        case .realm:
            addFavoriteToRealm(product)
        case .realtimeDatabase:
            addFavoriteToRealtimeDatabse(product)
        }
    }
    
    func removeFavorite(id: String) {
        switch source {
        case .coreData:
            removeFavoriteFromCoreData(id: id)
        case .realm:
            removeFavoriteFromRealm(id: id)
        case .realtimeDatabase:
            removeFavoriteRealtimeDatabse(id: id)
        }
    }
    
    func addFCartItem(_ product: ProductResponse) {
        switch source {
        case .coreData:
            break
        case .realm:
            addCartItemToRealm(product)
        case .realtimeDatabase:
            break
        }
    }
    
    func removeCartItem(id: String) {
        switch source {
        case .coreData:
            break
        case .realm:
            removeCartItemFromRealm(id: id)
        case .realtimeDatabase:
            break
        }
    }
}

// MARK: Private Methods (Realm)
extension DataManager {
    private func loadFavoritesFromRealm() -> [Favorite] {
        realm?.objects(RealmFavorite.self).compactMap { item in
            Favorite(identifier: item.identifier,
                     image: item.image,
                     name: item.name,
                     price: item.price)
        } ?? []
    }
    
    private func addFavoriteToRealm(_ product: ProductResponse) {
        try! realm?.write {
            realm?.add(RealmFavorite(identifier: product.id,
                                     image: product.image,
                                     name: product.name,
                                     price: product.price))
        }
    }
    
    private func removeFavoriteFromRealm(id: String) {
        try! realm?.write {
            if let favoriteToDelete = realm?.objects(RealmFavorite.self).where { $0.identifier == id } {
                realm?.delete(favoriteToDelete)
            }
        }
    }
    
    private func loadCartItemsFromRealm() -> [CartItem] {
           realm?.objects(RealmCartItem.self).compactMap { item in
               CartItem(identifier: item.identifier,
                        image: item.image,
                        name: item.name,
                        price: item.price)
           } ?? []
       }
       
       private func addCartItemToRealm(_ product: ProductResponse) {
           try! realm?.write {
               realm?.add(RealmCartItem(
   //                identifier: product.id,
                   identifier: UUID().uuidString,
                   image: product.image,
                   name: product.name,
                   price: product.price)
               )
           }
       }
       
       private func removeCartItemFromRealm(id: String) {
           try! realm?.write {
               if let cartItemToDelete = realm?.objects(RealmCartItem.self).where({ $0.identifier == id }) {
                   realm?.delete(cartItemToDelete)
               }
           }
       }
}

// MARK: Private Methods (Realtime Database)
extension DataManager {
    private func loadFavoritesFromRealtimeDatabse() {
        guard let loggedClient = getString(key: .userID) else {
            return
        }
        
        realtimeDatabase.child("favorites/\(loggedClient)/").getData { error, snapshot in
            guard error == nil, let snapshot = snapshot else {
                print(error!.localizedDescription)
                return
            }

            var favorites = [Favorite]()
            let dictionary = snapshot.value as? NSDictionary
            dictionary?.allValues.forEach { value in
                if let item = value as? NSDictionary {
                    favorites.append(.init(identifier: item["identifier"] as? String ?? "",
                                           image: item["image"] as? String ?? "",
                                           name: item["name"] as? String ?? "",
                                           price: item["price"] as? String ?? ""))
                }
            }

            NotificationCenter.default.post(name: Notification.Name("FavoritesUpdated"),
                                            object: nil,
                                            userInfo: ["favorites": favorites])
        }
        
        return
    }
    
    private func addFavoriteToRealtimeDatabse(_ product: ProductResponse) {
        guard let loggedClient = getString(key: .userID),
              let productId = product.id else {
            return
        }
        
        let newFavorite = RealtimeDatabaseFavorite(identifier: productId,
                                                   image: product.image,
                                                   name: product.name,
                                                   price: product.price)
        
        realtimeDatabase.child("favorites/\(loggedClient)/prd-\(productId)").setValue(newFavorite.toDictionary())
    }
    
    private func removeFavoriteRealtimeDatabse(id: String) {
        guard let loggedClient = getString(key: .userID) else {
            return
        }
        
        realtimeDatabase.child("favorites/\(loggedClient)/prd-\(id)").setValue(nil)
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
            return try coreDataStack.managedContext.fetch(favoritesFetch)
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
        
        let newFavorite = CoreDataFavorite(context: coreDataStack.managedContext)
        newFavorite.setValue(product.id, forKey: #keyPath(CoreDataFavorite.identifier))
        newFavorite.setValue(product.image, forKey: #keyPath(CoreDataFavorite.image))
        newFavorite.setValue(product.name, forKey: #keyPath(CoreDataFavorite.name))
        newFavorite.setValue(product.price, forKey: #keyPath(CoreDataFavorite.price))
        
        favorites.insert(newFavorite, at: 0)
        coreDataStack.saveContext()
    }
    
    private func removeFavoriteFromCoreData(id: String) {
        let favorites = getFavoritesFromCoreData()
        
        guard let index = favorites.firstIndex(where: { $0.identifier == id }) else {
            return
        }
        
        coreDataStack.managedContext.delete(favorites[index])
        coreDataStack.saveContext()
    }
}

// MARK: Private Methods (UserDefaults)
extension DataManager {
    private func saveStringUserDefaults(key: DataManagerKey, value: String) {
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    private func getStringUserDefaults(key: DataManagerKey) -> String? {
        userDefaults.string(forKey: key.rawValue)
    }
    
    private func saveIntUserDefaults(key: DataManagerKey, value: Int) {
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    private func getIntUserDefaults(key: DataManagerKey) -> Int? {
        userDefaults.integer(forKey: key.rawValue)
    }
    
    private func saveObjectUserDefaults<T: Codable>(key: DataManagerKey, value: T) {
        if let encoded = try? JSONEncoder().encode(value) {
            userDefaults.set(encoded, forKey: key.rawValue)
        }
    }
    
    private func getObjectUserDefaults<T: Codable>(key: DataManagerKey) -> T? {
        guard let data = userDefaults.object(forKey: key.rawValue) as? Data,
              let object = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        
        return object
    }
}

// MARK: Private Methods (KeyChain)
extension DataManager {
    private func saveStringKeyChain(key: DataManagerKey, value: String) {
        keychain.set(value, forKey: key.rawValue, withAccessibility: nil)
    }
    
    private func getStringKeyChain(key: DataManagerKey) -> String? {
        keychain.string(forKey: key.rawValue, withAccessibility: nil)
    }
    
    private func saveIntKeyChain(key: DataManagerKey, value: Int) {
        keychain.set(value, forKey: key.rawValue, withAccessibility: nil)
    }
    
    private func getIntKeyChain(key: DataManagerKey) -> Int? {
        keychain.integer(forKey: key.rawValue, withAccessibility: nil)
    }
    
    private func saveObjectKeyChain<T: Codable>(key: DataManagerKey, value: T) {
        if let encoded = try? JSONEncoder().encode(value) {
            keychain.set(encoded, forKey: key.rawValue, withAccessibility: nil)
        }
    }
    
    private func getObjectKeyChain<T: Codable>(key: DataManagerKey) -> T? {
        guard let data = keychain.data(forKey: key.rawValue, withAccessibility: nil),
              let object = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        
        return object
    }
}
