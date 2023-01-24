//
//  AppCoordinator.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 24/01/23.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    func showLoginFlow()
    func showMainFlow()
}

class AppCoordinator: AppCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators = [Coordinator]()
    
    var type: CoordinatorType { .app }
    
    func start() {
        showLoginFlow()
    }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    func showLoginFlow() {
        
        let controller = LoginViewController()
        navigationController.pushViewController(controller, animated: true)
//        let loginCoodinator = LoginCoordinator(navigationController)
//        loginCoodinator.finishDelegate = self
//        loginCoodinator.start()
//        childCoordinators.append(loginCoodinator)
    }
    
    func showMainFlow() {
//        let tabCoordinator = TabCoordinator(navigationController)
//        tabCoordinator.finishDelegate = self
//        tabCoordinator.start()
//        childCoordinators.append(tabCoordinator)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
        
        switch childCoordinator.type {
        case .login:
            navigationController.viewControllers.removeAll()
            showMainFlow()
        case .tab:
            navigationController.viewControllers.removeAll()
            showLoginFlow()
        default:
            break
        }
    }
}
