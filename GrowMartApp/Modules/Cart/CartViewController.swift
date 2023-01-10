//
//  CartViewController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 06/09/22.
//

import UIKit
import RealmSwift

public enum CartCellType {
    case product
    case total
    case button
}

struct CartCell {
    let cellType: CartCellType
    let data: Any?
}

class CartViewController: BaseViewController {
    
    private var cartView: CartView?
    private var realm = try! Realm()
    private var cartItems: [CartItem]? {
        didSet {
            cartView?.reloadTableView()
        }
    }
    
    override func loadView() {
        super.loadView()
        
        cartView = .init()
        view = cartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartView?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        cartItems = loadCartItemsFromRealm()
        cartView?.reloadTableView()
    }
    
}

extension CartViewController {
    private func loadCartItemsFromRealm() -> [CartItem] {
        realm.objects(RealmCartItem.self).compactMap { item in
            CartItem(identifier: item.identifier,
                     image: item.image,
                     name: item.name,
                     price: item.price)
        }
    }
    
    private func removeCartItemFromRealm(id: String) {
        try! realm.write {
            let cartItemToDelete = realm.objects(RealmCartItem.self).where({ $0.identifier == id })
            realm.delete(cartItemToDelete)
            
        }
    }
}

extension CartViewController: CartViewDelegate {
    
    func numberOfRows() -> Int {
        cartItems?.count ?? 0
    }
    
//    func getCartCellType(at index: Int) -> CartCellType? {
//        //        guard let cartItems = cartItems, index < cartItems.count else {
//        //                    return nil
//        //                }
//        //
//        //                return cartItems[index]
//        return nil
//    }
    
    func getCartItem(at index: Int) -> CartItem? {
        guard let cartItems = cartItems, index < cartItems.count else {
            return nil
        }
        
        return cartItems[index]
    }
    
    func getTotal() -> String {
        var total: Double = 0
        
        cartItems?.forEach { item in
            total += item.getPriceAsDouble()
        }
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // USA: Locale(identifier: "en_US")
        formatter.numberStyle = .decimal
        let totalFormatted = formatter.string(from: NSNumber(value: total)) ?? ""
        
        return "R$ \(totalFormatted)"
    }
    
    func getButtonTitle() -> String {
        //        guard let buttonTitle = cells.first(where: { $0.cellType == .button })?.data as? String else {
        //            return ""
        //        }
        
        return ""
    }
    
    func didTapButton() {
        print("didTapButton")
    }
    
    func remove(cartItem: CartItem) {
        guard let identifier = cartItem.identifier else { return }
        removeCartItemFromRealm(id: identifier)
        cartItems?.removeAll(where: { $0.identifier == identifier})
        cartView?.reloadTableView()
    }
}
