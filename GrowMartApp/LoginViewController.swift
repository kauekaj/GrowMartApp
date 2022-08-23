//
//  ViewController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 22/08/22.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Private Properties
    
    private lazy var stackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .vertical
        element.spacing = 27
        return element
    }()

    private lazy var logoImageView: UIImageView = {
       let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFit
        element.image = UIImage(named: "growmart")
        return element
    }()

    private lazy var bagsImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFit
        element.image = UIImage(named: "sacolas")
        return element
    }()

    private lazy var facebookButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitleColor(.white, for: .normal)
        element.addTarget(self, action: #selector(didTappedFacebookLogin), for: .touchUpInside)
        element.layer.cornerRadius = 8
        element.configuration = getButtonConfigurations(backgroundColor: .init(rgb: 0x4267B2),
                                                        title: "ENTRAR COM FACEBOOK",
                                                        icon: UIImage(named: "facebook-logo"))
        return element
    }()

    private lazy var googleButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitleColor(.white, for: .normal)
        element.addTarget(self, action: #selector(didTappedGoogleLogin), for: .touchUpInside)
        element.layer.cornerRadius = 8
        element.configuration = getButtonConfigurations(backgroundColor: .init(rgb: 0xDB4437),
                                                        title: "ENTRAR COM GOOGLE",
                                                        icon: UIImage(named: "google-logo"))
        return element
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Methods
    private func getButtonConfigurations(backgroundColor: UIColor,
                                         title: String,
                                         icon: UIImage?) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.image = icon
        configuration.titlePadding = 10
        configuration.imagePadding = 30
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        configuration.background.backgroundColor = backgroundColor
        return configuration
    }

    // MARK: - Actions

    @objc
    private func didTappedFacebookLogin() {
        print("didTappedFacebookLogin")
    }

    @objc
    private func didTappedGoogleLogin() {
        print("didTappedGoogleLogin")
    }

}

// MARK: - ViewCodable

extension LoginViewController: ViewCodable {
    func buildHierarchy() {
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(bagsImageView)
        stackView.addArrangedSubview(facebookButton)
        stackView.addArrangedSubview(googleButton)

        view.addSubview(stackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60),
            logoImageView.heightAnchor.constraint(equalToConstant: 49),
            bagsImageView.heightAnchor.constraint(equalToConstant: 106),
            facebookButton.heightAnchor.constraint(equalToConstant: 41),
            googleButton.heightAnchor.constraint(equalToConstant: 41)
        ])
    }

    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
        stackView.setCustomSpacing(16, after: facebookButton)
    }
}
