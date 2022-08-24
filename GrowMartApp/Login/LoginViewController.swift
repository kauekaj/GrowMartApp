//
//  ViewController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 22/08/22.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Internal Properties
    private lazy var loginView: LoginView = {
        let element = LoginView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

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
}

extension LoginViewController: LoginViewDelegate {
    func didTapFacebookLogin() {
        print("didTapFacebookLogin")
    }

    func didTapGoogleLogin() {
        print("didTapGoogleLogin")
    }
}
