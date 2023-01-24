//
//  TabCoordinator.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 24/01/23.
//

import UIKit

enum TabBarPage {
    case home
    case sell
    case cart
    case favorites
    case profile
    
    init?(index: Int) {
        switch index {
        case 0:
            self = .home
        case 1:
            self = .sell
        case 2:
            self = .cart
        case 3:
            self = .favorites
        case 4:
            self = .profile
        default:
            return nil
        }
    }
    
    func getTitle() -> String {
        switch self {
        case .home:
            return "Home"
        case .sell:
            return "Vender"
        case .cart:
            return "Carrinho"
        case .favorites:
            return "Favoritos"
        case .profile:
            return "Perfil"
        }
    }
    
    func getOrderNumber() -> Int {
        switch self {
        case .home:
            return 0
        case .sell:
            return 1
        case .cart:
            return 2
        case .favorites:
            return 3
        case .profile:
            return 4
        }
    }
    
    func getIcon() -> UIImage? {
        switch self {
        case .home:
            return getTabIcon(name: "home")
        case .sell:
            return getTabIcon(name: "catalog")
        case .cart:
            return getTabIcon(name: "cart")
        case .favorites:
            return getTabIcon(systemImage: .starFill)
        case .profile:
            return getTabIcon(name: "profile")
        }
    }
    
    func getSelectedIcon() -> UIImage? {
        switch self {
        case .home:
            return getTabIcon(name: "home", color: 0x1E3D59)
        case .sell:
            return getTabIcon(name: "catalog", color: 0x1E3D59)
        case .cart:
            return getTabIcon(name: "cart", color: 0x1E3D59)
        case .favorites:
            return getTabIcon(systemImage: .starFill, color: 0x1E3D59)
        case .profile:
            return getTabIcon(name: "profile", color: 0x1E3D59)
        }
    }
    
    private func getTabIcon(name: String, color: Int = 0xA0A4A8) -> UIImage? {
        return .makeWith(name: "tab-\(name)", color: .init(rgb: color))
    }
    
    private func getTabIcon(systemImage: UIImage.SystemImage, color: Int = 0xA0A4A8) -> UIImage? {
        return .makeWith(systemImage: systemImage, color: .init(rgb: color))
    }
}

protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    
    func setSelectedIndex(_ index: Int)
    
    func currentPage() -> TabBarPage
}

class TabCoordinator: NSObject, TabCoordinatorProtocol {
    var tabBarController: UITabBarController
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators = [Coordinator]()
    
    var type: CoordinatorType { .tab }
    
    func start() {
        // Let's define which pages do we want to add into tab bar
        let pages: [TabBarPage] = [
            .cart,
            .home,
            .profile,
            .sell,
            .favorites
        ].sorted(by: { $0.getOrderNumber() < $1.getOrderNumber() })
        
        // Initialization of ViewControllers or these pages
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        
        prepareTabBarController(withTabControllers: controllers)
    }
    
    deinit {
        print("TabCoordinator deinit")
    }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }
    
    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.getOrderNumber()
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else { return }

        tabBarController.selectedIndex = page.getOrderNumber()
    }
    
    func currentPage() -> TabBarPage {
        guard let page = TabBarPage.init(index: tabBarController.selectedIndex) else {
            return .home
        }
        
        return page
    }
}

extension TabCoordinator {
    
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)

        navController.tabBarItem = UITabBarItem.init(title: page.getTitle(),
                                                     image: page.getIcon(),
                                                     selectedImage: page.getSelectedIcon())

        switch page {
        case .home:
            let controller = SelectorViewController()
//            controller.didSelectCategoryClosure = { [weak self] _ in
//                self?.selectPage(.sell)
//            }
//            controller.logoutClosure = { [weak self] in
//                self?.finish()
//            }
            navController.pushViewController(controller, animated: true)
        case .sell:
            let controller = CatalogViewController()
//            controller.didTapProductClosure = { [weak self] _ in
//                self?.navigationController.pushViewController(ProductDetailViewController(),
//                                                              animated: true)
//            }
            navController.pushViewController(controller, animated: true)
        case .cart:
            let controller = CartViewController()
            navController.pushViewController(controller, animated: true)
        case .favorites:
            let controller = FavoritesViewController()
            navController.pushViewController(controller, animated: true)
        case .profile:
            let controller = ProfileViewController()
            navController.pushViewController(controller, animated: true)
        }
        
        return navController
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.home.getOrderNumber()

        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0.0,
                                 y: 0.0,
                                 width: UIScreen.main.bounds.width,
                                 height: 0.5)
        topBorder.backgroundColor = UIColor(rgb: 0x999999).cgColor
        tabBarController.tabBar.layer.addSublayer(topBorder)
        tabBarController.tabBar.clipsToBounds = true

        UITabBarItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x1E3D59)
        ], for: .selected)
        
        navigationController.viewControllers = [tabBarController]
    }
}

// MARK: - UITabBarControllerDelegate
extension TabCoordinator: UITabBarControllerDelegate { }
