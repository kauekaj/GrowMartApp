//
//  DataManagerTests.swift
//  GrowMartAppTests
//
//  Created by Kaue de Assis Jacyntho on 21/11/22.
//

import XCTest
import RealmSwift
@testable import GrowMartApp

class DataManagerTests: BaseTests {
    
    private lazy var sut = DataManager.shared
    private lazy var userDefaultsSpy = UserDefaultsSpy()
    private lazy var keychainSpy = KeychainSpy()
    private var testRealm = try! Realm(configuration: .init(inMemoryIdentifier: "DataManagerTests"))
    
    override func setUp() {
        super.setUp()
        setupCoreData()
        
    }
    
    override func tearDown() {
        try! testRealm.write {
            testRealm.deleteAll()
        }
    }
    
    // MARK: - Private Methods
    
    private func setupCoreData() {
        sut.setup(source: .coreData,
                  realm: testRealm,
                  coreDataStack: .init(modelName: "Favorites", isInMemoryStoreType: true),
                  userDefaults: userDefaultsSpy,
                  keychain: keychainSpy)
        
    }
    
    private func setupRealm() {
        sut.setup(source: .realm,
                  realm: testRealm,
                  coreDataStack: .init(modelName: "Favorites", isInMemoryStoreType: true),
                  userDefaults: userDefaultsSpy,
                  keychain: keychainSpy)
        
    }
    
    
    
    // MARK: - UserDefaults Tests
    
    func testSaveStringShouldCallSetMethod() {
        XCTAssertEqual(userDefaultsSpy.calledMethods, [])
        sut.saveString(key: .userName, value: "TEST")
        XCTAssertEqual(userDefaultsSpy.calledMethods, [.set])
        sut.saveString(key: .userName, value: nil)
        XCTAssertEqual(userDefaultsSpy.calledMethods, [.set, .set])
    }
    
    func testSaveIntShouldCallSetMethod() {
        XCTAssertEqual(userDefaultsSpy.calledMethods, [])
        sut.saveInt(key: .userName, value: 1)
        XCTAssertEqual(userDefaultsSpy.calledMethods, [.set])
        sut.saveInt(key: .userName, value: nil)
        XCTAssertEqual(userDefaultsSpy.calledMethods, [.set, .set])
    }
    
    func testSaveObjectShouldCallSetMethod() {
        XCTAssertEqual(userDefaultsSpy.calledMethods, [])
        sut.saveObject(key: .userName, value: AuthResponse())
        XCTAssertEqual(userDefaultsSpy.calledMethods, [.set])
        let nilData: AuthResponse? = nil
        sut.saveObject(key: .userName, value: nilData)
        XCTAssertEqual(userDefaultsSpy.calledMethods, [.set, .set])
    }
    
    func testGetStringShouldCallGetMethod() {
        // GIVEN -> DADO
        userDefaultsSpy.valueToBeReturned = "TEST"
        
        // WHEN -> QUANDO
        let response = sut.getString(key: .userName)
        
        // THEN -> ENTÃO
        XCTAssertEqual(userDefaultsSpy.calledMethods, [.string])
        XCTAssertEqual(response, "TEST")
    }
    
    func testGetIntShouldCallGetMethod() {
        // GIVEN -> DADO
        userDefaultsSpy.valueToBeReturned = 1
        
        // WHEN -> QUANDO
        let response = sut.getInt(key: .userName)
        
        // THEN -> ENTÃO
        XCTAssertEqual(userDefaultsSpy.calledMethods, [.integer])
        XCTAssertEqual(response, 1)
    }
    
    func testGetObjectShouldCallGetMethod() throws {
        // GIVEN -> DADO
        let result = AuthResponse()
        let data = try XCTUnwrap(JSONEncoder().encode(result))
        userDefaultsSpy.valueToBeReturned = data
        
        // WHEN -> QUANDO
        let response: AuthResponse? = sut.getObject(key: .userName)
        
        // THEN -> ENTÃO
        XCTAssertEqual(userDefaultsSpy.calledMethods, [.object])
        XCTAssertEqual(response, result)
    }
    
    func testGetInvalidObjectShouldCallGetMethod() {
        // GIVEN -> DADO
        userDefaultsSpy.valueToBeReturned = "A INVALID STRING..."
        
        // WHEN -> QUANDO
        let response: AuthResponse? = sut.getObject(key: .userName)
        
        // THEN -> ENTÃO
        XCTAssertEqual(userDefaultsSpy.calledMethods, [.object])
        XCTAssertEqual(response, nil)
    }
    
    // MARK: - Keychain Tests
    
    func testSaveStringSecureShouldCallSetMethod() {
        XCTAssertEqual(keychainSpy.calledMethods, [])
        sut.saveString(key: .userName, value: "TEST", isSecure: true)
        XCTAssertEqual(keychainSpy.calledMethods, [.setString])
        sut.saveString(key: .userName, value: nil, isSecure: true)
        XCTAssertEqual(keychainSpy.calledMethods, [.setString, .setString])
    }
    
    func testSaveIntSecureShouldCallSetMethod() {
        XCTAssertEqual(keychainSpy.calledMethods, [])
        sut.saveInt(key: .userName, value: 1, isSecure: true)
        XCTAssertEqual(keychainSpy.calledMethods, [.setInt])
        sut.saveInt(key: .userName, value: nil, isSecure: true)
        XCTAssertEqual(keychainSpy.calledMethods, [.setInt, .setInt])
    }
    
    func testSaveDataSecureShouldCallSetMethod() {
        XCTAssertEqual(keychainSpy.calledMethods, [])
        sut.saveObject(key: .userName, value: AuthResponse(), isSecure: true)
        XCTAssertEqual(keychainSpy.calledMethods, [.setData])
        let nilData: AuthResponse? = nil
        sut.saveObject(key: .userName, value: nilData, isSecure: true)
        XCTAssertEqual(keychainSpy.calledMethods, [.setData, .setData])
    }
    
    func testGetStringSecureShouldCallSetMethod() {
        // GIVEN -> DADO
        keychainSpy.valueToBeReturned = "TEST"
        
        // WHEN -> QUANDO
        let response = sut.getString(key: .userName, isSecure: true)
        
        // THEN -> ENTÃO
        XCTAssertEqual(keychainSpy.calledMethods, [.string])
        XCTAssertEqual(response, "TEST")
    }
    
    func testGetIntSecureShouldCallSetMethod() {
        // GIVEN -> DADO
        keychainSpy.valueToBeReturned = 1
        
        // WHEN -> QUANDO
        let response = sut.getInt(key: .userName, isSecure: true)
        
        // THEN -> ENTÃO
        XCTAssertEqual(keychainSpy.calledMethods, [.integer])
        XCTAssertEqual(response, 1)
    }
    
    func testGetObjectSecureShouldCallSetMethod() throws {
        // GIVEN -> DADO
        let result = AuthResponse()
        let data = try XCTUnwrap(JSONEncoder().encode(result))
        keychainSpy.valueToBeReturned = data
        
        // WHEN -> QUANDO
        let response: AuthResponse? = sut.getObject(key: .userName, isSecure: true)
        
        // THEN -> ENTÃO
        XCTAssertEqual(keychainSpy.calledMethods, [.data])
        XCTAssertEqual(response, result)
    }
    
    func testGetInvalidObjectSecureShouldCallSetMethod() throws {
        // GIVEN -> DADO
        keychainSpy.valueToBeReturned = "A INVALID STRING..."
        
        // WHEN -> QUANDO
        let response: AuthResponse? = sut.getObject(key: .userName, isSecure: true)
        
        // THEN -> ENTÃO
        XCTAssertEqual(keychainSpy.calledMethods, [.data])
        XCTAssertEqual(response, nil)
    }
    
    // MARK: - CoreData Tests
    
    func testSaveNewFavoriteShouldPersistOnCoreData() {
        // GIVEN -> DADO
        XCTAssertEqual(sut.loadFavorites().count, 0)
        
        // WHEN -> QUANDO
        sut.addFavorite(.fixture())
        
        // THEN -> ENTÃO
        XCTAssertEqual(sut.loadFavorites().count, 1)
    }
    
    func testLoadFavoritesShouldReturnCorrectListFromCoreData() {
        sut.addFavorite(.fixture())
        sut.addFavorite(.fixture())
        sut.addFavorite(.fixture())
        sut.addFavorite(.fixture())
        sut.addFavorite(.fixture())
        XCTAssertEqual(sut.loadFavorites().count, 5)
    }
    
    func testRemoveFavoriteShouldDeleteOnCoreData() {
        // GIVEN -> DADO
        sut.addFavorite(.fixture())
        
        // WHEN -> QUANDO
        sut.removeFavorite(id: "1")
        
        // THEN -> ENTÃO
        XCTAssertEqual(sut.loadFavorites().count, 0)
    }
    
    func testRemoveInvalidFavoriteShouldDeleteOnCoreData() {
        // GIVEN -> DADO
        sut.addFavorite(.fixture())
        
        // WHEN -> QUANDO
        sut.removeFavorite(id: "2")
        
        // THEN -> ENTÃO
        XCTAssertEqual(sut.loadFavorites().count, 1)
    }
    
    // MARK: - Realm Tests
    
    func testSaveNewFavoriteShouldPersistOnRealm() {
        // GIVEN -> DADO
        setupRealm()
        XCTAssertEqual(sut.loadFavorites().count, 0)
        
        // WHEN -> QUANDO
        sut.addFavorite(.fixture())
        
        // THEN -> ENTÃO
        XCTAssertEqual(sut.loadFavorites().count, 1)
    }
    
    func testLoadFavoritesShouldReturnCorrectListFromRealm() {
        setupRealm()
        
        sut.addFavorite(.fixture())
        sut.addFavorite(.fixture())
        sut.addFavorite(.fixture())
        sut.addFavorite(.fixture())
        sut.addFavorite(.fixture())
        XCTAssertEqual(sut.loadFavorites().count, 5)
    }
    
    func testRemoveFavoriteShouldDeleteOnRealm() {
        setupRealm()
        
        sut.addFavorite(.fixture())
        sut.removeFavorite(id: "1")
        XCTAssertEqual(sut.loadFavorites().count, 0)
    }
    
}

// MARK: - Spy Classes
class UserDefaultsSpy: UserDefaultsActions {
    enum Methods {
        case set
        case string
        case integer
        case object
    }
    
    private(set) var calledMethods = [Methods]()
    var valueToBeReturned: Any?
    
    func set(_ value: Any?, forKey: String) {
        calledMethods.append(.set)
    }
    
    func string(forKey: String) -> String? {
        calledMethods.append(.string)
        return valueToBeReturned as? String
    }
    
    func integer(forKey: String) -> Int {
        calledMethods.append(.integer)
        return valueToBeReturned as? Int ?? 0
    }
    
    func object(forKey: String) -> Any? {
        calledMethods.append(.object)
        return valueToBeReturned
    }
}

class KeychainSpy: KeychainActions {
    enum Methods {
        case setInt
        case setString
        case setData
        case string
        case integer
        case data
    }
    
    private(set) var calledMethods = [Methods]()
    var valueToBeReturned: Any?
    
    func integer(forKey key: String,
                 withAccessibility accessibility: GrowMartApp.KeychainItemAccessibility?) -> Int? {
        calledMethods.append(.integer)
        return valueToBeReturned as? Int
    }
    
    func string(forKey key: String,
                withAccessibility accessibility: GrowMartApp.KeychainItemAccessibility?) -> String? {
        calledMethods.append(.string)
        return valueToBeReturned as? String
    }
    
    func data(forKey key: String,
              withAccessibility accessibility: GrowMartApp.KeychainItemAccessibility?) -> Data? {
        calledMethods.append(.data)
        return valueToBeReturned as? Data
    }
    
    func set(_ value: Int, forKey key: String, withAccessibility accessibility: GrowMartApp.KeychainItemAccessibility?) -> Bool {
        calledMethods.append(.setInt)
        return true
    }
    
    func set(_ value: String, forKey key: String, withAccessibility accessibility: GrowMartApp.KeychainItemAccessibility?) -> Bool {
        calledMethods.append(.setString)
        return true
    }
    
    func set(_ value: Data, forKey key: String, withAccessibility accessibility: GrowMartApp.KeychainItemAccessibility?) -> Bool {
        calledMethods.append(.setData)
        return true
    }
    
}
