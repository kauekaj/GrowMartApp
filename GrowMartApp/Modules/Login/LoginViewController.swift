//
//  ViewController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 22/08/22.
//

import UIKit

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
        networkManager.execute(
            endpoint: AuthApi.auth(login: login, password: password)) { [weak self] (response: Result<AuthResponse?, NetworkResponse>) in
                guard let safeSelf = self else { return }
                
                switch response {
                case let .success(data):
                    guard let userData = data else {
                        // Apresentar estado de erro
                        return
                    }
                    
                    safeSelf.persistUserInfo(user: userData)
                    safeSelf.showHomeScreen()
                case .failure:
                    // Apresentar estado de erro
                    break
                }
            }
    }
    
    private func showHomeScreen() {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(TabBarViewController(),
                                                          animated: true)
        }
    }
    
    // FONTE: https://www.hackingwithswift.com/example-code/system/how-to-save-user-settings-using-userdefaults
    
    private func persistUserInfo(user: AuthResponse) {
        persistOnUserDefauts(user)
        persistOnKeychain(user)
        
        printSeparators()
            let userDefaultsName = UserDefaults.standard.string(forKey: "UserName")
            let keyChainName = KeychainWrapper.standard.string(forKey: "UserName")
            
            print("Data saved on both: \(userDefaultsName == keyChainName)")
        }
        
        func printSeparators() {
            print("")
            print("--------------------------------------------")
            print("")
        }
    
    private func persistOnUserDefauts(_ user: AuthResponse) {
        printSeparators()
        let defaults = UserDefaults.standard
        
        defaults.set(user.id, forKey: "UserID")
        defaults.set(user.name, forKey: "UserName")
        defaults.set(user.email, forKey: "UserEmail")
        defaults.set(user.phone, forKey: "UserPhone")
        
        if let encoded = try? JSONEncoder().encode(user) {
            defaults.set(encoded, forKey: "User")
        }
        
        print("Name saved on UserDefaults: \(defaults.string(forKey: "UserName") ?? "NOT SAVED")")
        
        if let data = defaults.object(forKey: "User") as? Data,
           let user = try? JSONDecoder().decode(AuthResponse.self, from: data) {
            print("User saved on UserDefaults: \(user)")
        } else {
            print("User saved on UserDefaults: NOT SAVED")
        }
    }
    
    private func persistOnKeychain(_ user: AuthResponse) {
        printSeparators()
        let keyChain = KeychainWrapper.standard
        
        if let id = user.id { keyChain.set(id, forKey: "UserID") }
        if let name = user.name { keyChain.set(name, forKey: "UserName") }
        if let email = user.email { keyChain.set(email, forKey: "UserEmail") }
        if let phone = user.phone { keyChain.set(phone, forKey: "UserPhone") }
        
        print("Name saved on Keychain: \(keyChain.string(forKey: "UserName") ?? "NOT SAVED")")

        if let encoded = try? JSONEncoder().encode(user) {
                   keyChain.set(encoded, forKey: "User")
               }
               
               if let data = keyChain.data(forKey: "User"),
                  let user = try? JSONDecoder().decode(AuthResponse.self, from: data) {
                   print("User saved on Keychain: \(user)")
               } else {
                   print("User saved on Keychain: NOT SAVED")
               }
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
