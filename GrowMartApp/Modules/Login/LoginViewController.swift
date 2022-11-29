//
//  ViewController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 22/08/22.
//

// FONTE: https://www.hackingwithswift.com/example-code/system/how-to-save-user-settings-using-userdefaults

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    // MARK: - Private Properties
    private lazy var loginView: LoginView = {
        let element = LoginView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var networkManager = NetworkManager(router: Router())
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Private Methods
    private func setupView() {
        loginView.delegate = self
        view.addSubview(loginView)
        
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func authUser(login: String, password: String) {
//        networkManager.execute(
//            endpoint: AuthApi.auth(login: login, password: password)) { [weak self] (response: Result<AuthResponse?, NetworkResponse>) in
//                guard let safeSelf = self else { return }
//
//                switch response {
//                case let .success(data):
//                    guard let userData = data else {
//                        // Apresentar estado de erro
//                        return
//                    }
//
//                    safeSelf.persistUserInfo(user: userData)
//                    safeSelf.showHomeScreen()
//                case .failure:
//                    // Apresentar estado de erro
//                    break
//                }
//            }
        
        Auth.auth().signIn(withEmail: login, password: password) { [weak self] authResult, error in
            guard let safeself = self,
                  error == nil,
                  let user = authResult?.user else {
                self?.showLoginError()
                return
            }
            
            safeself.persistUserInfo(user: .init(id: user.uid,
                                                 name: user.displayName,
                                                 email: user.email,
                                                 phone: user.phoneNumber))
            safeself.showHomeScreen()
        }
    }
    
    private func showLoginError() {
            let alert = UIAlertController(title: "Erro!",
                                                 message: "Dados inválidos, tente novamente.",
                                                 preferredStyle: .alert)

            alert.addAction(.init(title: "Ok", style: .cancel, handler: nil))
            
            present(alert, animated: true, completion: nil)
        }
    
    private func showHomeScreen() {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(TabBarViewController(),
                                                          animated: true)
        }
    }
        
    private func persistUserInfo(user: AuthResponse) {
        
        let manager = DataManager.shared
        
        manager.saveString(key: .userID, value: user.id)
        manager.saveString(key: .userName, value: user.name)
        manager.saveString(key: .userEmail, value: user.email, isSecure: true)
        manager.saveString(key: .userPhone, value: user.phone, isSecure: true)
        
        manager.saveObject(key: .user, value: user, isSecure: true)
        
        // PRINTS DE DEBUG
        print("Name saved: \(manager.getString(key: .userName) ?? "NOT SAVED")")
        print("Email saved: \(manager.getString(key: .userEmail, isSecure: true) ?? "NOT SAVED")")
        
        let user: AuthResponse? = manager.getObject(key: .user, isSecure: true)
        print("User saved: \(String(describing: user)) ")
        // --------------
    }
    
}

extension LoginViewController: LoginViewDelegate {
    func didTapLogin(login: String, password: String) {
        authUser(login: login, password: password)
    }
    
    func didTapFacebookLogin() {
        print("didTapFacebookLogin")
        let controller = TabBarViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func didTapGoogleLogin() {
        print("didTapGoogleLogin")
        let controller = TabBarViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
