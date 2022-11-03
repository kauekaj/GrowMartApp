//
//  TabBarController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 03/11/22.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let navigationBar = navigationController?.navigationBar
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.shadowColor = .lightGray
        navigationBar?.standardAppearance = navigationBarAppearance
        navigationBar?.compactAppearance = navigationBarAppearance
        navigationBar?.scrollEdgeAppearance = navigationBarAppearance
        navigationBar?.compactScrollEdgeAppearance = navigationBarAppearance
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        UITabBarItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x1E3D59)
        ], for: .selected)

        viewControllers = [
            getTabHome(),
            getTabCatalog(),
            getTabCart(),
            getTabFavorites(),
            getTabProfile()
        ]
    }
    
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {

    }
    
    private func getTabHome() -> UINavigationController {
        let tabHome = SelectorViewController()
        let tabHomeBarItem = UITabBarItem(title: "Home",
                                          image: .makeWith(name: "tab-home",
                                                           color: .init(rgb: 0xA0A4A8)),
                                          selectedImage: .makeWith(name: "tab-home",
                                                                   color: .init(rgb: 0x1E3D59)))
        tabHome.tabBarItem = tabHomeBarItem
        
        return UINavigationController(rootViewController: tabHome)
    }
    
    private func getTabCatalog() -> UINavigationController {
        let tabCatalog = CatalogViewController()
        let tabCatalogBarItem = UITabBarItem(title: "Vender",
                                             image: .makeWith(name: "tab-catalog",
                                                              color: .init(rgb: 0xA0A4A8)),
                                             selectedImage: .makeWith(name: "tab-catalog",
                                                                      color: .init(rgb: 0x1E3D59)))

        tabCatalog.tabBarItem = tabCatalogBarItem
        
        return UINavigationController(rootViewController: tabCatalog)
    }
    
    private func getTabCart() -> UINavigationController {
        let tabCart = CartViewController()
        let tabCartBarItem = UITabBarItem(title: "Carrinho",
                                          image: .makeWith(name: "tab-cart",
                                                           color: .init(rgb: 0xA0A4A8)),
                                          selectedImage: .makeWith(name: "tab-cart",
                                                                   color: .init(rgb: 0x1E3D59)))

        tabCart.tabBarItem = tabCartBarItem
        
        return UINavigationController(rootViewController: tabCart)
    }
    
    private func getTabFavorites() -> UINavigationController {
        let tabFavorites = CartViewController()
        let tabFavoritesBarItem = UITabBarItem(title: "Favoritos",
                                               image: .makeWith(systemImage: .starFill,
                                                                color: .init(rgb: 0xA0A4A8)),
                                               selectedImage: .makeWith(systemImage: .starFill,
                                                                        color: .init(rgb: 0x1E3D59)))

        tabFavorites.tabBarItem = tabFavoritesBarItem
        
        return UINavigationController(rootViewController: tabFavorites)
    }
    
    private func getTabProfile() -> UINavigationController {
        let tabProfile = ProfileViewController()
        let tabProfileBarItem = UITabBarItem(title: "Perfil",
                                          image: .makeWith(name: "tab-profile",
                                                           color: .init(rgb: 0xA0A4A8)),
                                          selectedImage: .makeWith(name: "tab-profile",
                                                                   color: .init(rgb: 0x1E3D59)))

        tabProfile.tabBarItem = tabProfileBarItem
        
        return UINavigationController(rootViewController: tabProfile)
    }
}
