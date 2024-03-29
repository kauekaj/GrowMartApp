//
//  ViewController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 22/08/22.
//

// FONTE: https://www.hackingwithswift.com/example-code/system/how-to-save-user-settings-using-userdefaults

import UIKit
import FirebaseAuth
import FirebaseRemoteConfig

class LoginViewController: UIViewController {
    
    enum AuthenticationType: String {
        case firebase = "FIREBASE"
        case api = "API"
    }
    
    var loginFinishedClosure: (() -> Void)?
    
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
//        loginView.delegate = self
        
        loginView.didTapLoginBlock = { [weak self] login, pass in
            self?.authUser(login: login, password: pass)
        }
        
        loginView.didTapFacebookLoginBlock = { [weak self] in
//            self?.navigationController?.pushViewController(TabBarViewController(), animated: true)
            self?.loginFinishedClosure?()
        }
        
        loginView.didTapGoogleLoginBlock = { [weak self] in
//            self?.navigationController?.pushViewController(TabBarViewController(), animated: true)
        }
        
        view.addSubview(loginView)
        
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func finishLogin() {
        DispatchQueue.main.async {
            self.loginFinishedClosure?()
        }
    }
    
    private func authUser(login: String, password: String) {
        
        self.showHomeScreen()
//        let authenticationTypeConfig = AppDelegate.sharedAppDelegate.remoteConfig.configValue(forKey: "ft_authentication_type").stringValue
//
//        if authenticationTypeConfig == AuthenticationType.api.rawValue {
//            networkManager.execute(
//                endpoint: AuthApi.auth(login: login, password: password)) { [weak self] (response: Result<AuthResponse?, NetworkResponse>) in
//                    guard let safeSelf = self else { return }
//
//                    switch response {
//                    case let .success(data):
//                        guard let userData = data else {
//                            // Apresentar estado de erro
//                            return
//                        }
//
//                        safeSelf.persistUserInfo(user: userData)
//                        safeSelf.showHomeScreen()
//                    case .failure:
//                        // Apresentar estado de erro
//                        break
//                    }
//                }
//        } else {
//            Auth.auth().signIn(withEmail: login, password: password) { [weak self] authResult, error in
//                guard let safeself = self,
//                      error == nil,
//                      let user = authResult?.user else {
//                    self?.showLoginError()
//                    return
//                }
//
//                safeself.persistUserInfo(user: .init(id: user.uid,
//                                                     name: user.displayName,
//                                                     email: user.email,
//                                                     phone: user.phoneNumber))
//                safeself.showHomeScreen()
//            }
//        }
    }
    
    private func showLoginError() {
        let alert = UIAlertController(title: Strings.alertTitle,
                                      message: Strings.alertMessage,
                                      preferredStyle: .alert)
        
        alert.addAction(.init(title: Strings.alertButtonTitle, style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func showHomeScreen() {
        finishLogin()
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
        finishLogin()
    }
    
    func didTapGoogleLogin() {
        print("didTapGoogleLogin")
        finishLogin()
    }
}
