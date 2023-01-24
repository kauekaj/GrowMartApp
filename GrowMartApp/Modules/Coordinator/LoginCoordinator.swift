//
//  LoginCoordinator.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 24/01/23.
//

import UIKit

protocol LoginCoordinatorProtocol: Coordinator {
    func showLoginViewController()
}

class LoginCoordinator: LoginCoordinatorProtocol {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators = [Coordinator]()
    
    var type: CoordinatorType { .login }
    
    func start() {
        showLoginViewController()
    }
    
    deinit {
        print("LoginCoordinator deinit")
    }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showLoginViewController() {
        let controller = LoginViewController()
        controller.loginFinishedClosure = { [weak self] in
            self?.finish()
        }
        navigationController.pushViewController(controller, animated: true)
    }
}
