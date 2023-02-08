//
//  LoginView.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 23/08/22.
//

import UIKit

public protocol LoginViewDelegate: AnyObject {
    func didTapFacebookLogin()
    func didTapGoogleLogin()
    func didTapLogin(login: String, password: String)
}

class LoginView: UIView {
    // MARK: - Public Properties
    weak var delegate: LoginViewDelegate?

    var didTapFacebookLoginBlock: (() -> Void)?
    var didTapGoogleLoginBlock: (() -> Void)?
    var didTapLoginBlock: ((String, String) -> Void)?
    
    // MARK: - Private Properties
    private lazy var stackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .vertical
        element.spacing = 16
        return element
    }()

    private lazy var logoImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.masksToBounds = true
        element.contentMode = .scaleAspectFit
        element.image = Asset.Images.growmart.image
        return element
    }()

    private lazy var bagsImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.masksToBounds = true
        element.contentMode = .scaleAspectFit
        element.image = Asset.Images.sacolas.image
        return element
    }()
    
    private lazy var loginTextField: RightIconTextField = {
        let element = RightIconTextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.borderColor = UIColor(rgb: 0x25282B).cgColor
        element.layer.borderWidth = 1
        element.layer.cornerRadius = 5
        element.font = .nunito(style: .regular, size: 18)
        element.placeholder = "login"
        return element
    }()
    
    private lazy var passwordTextField: RightIconTextField = {
        let element = RightIconTextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.borderColor = UIColor(rgb: 0x25282B).cgColor
        element.layer.borderWidth = 1
        element.layer.cornerRadius = 5
        element.font = .nunito(style: .regular, size: 18)
        element.isSecureTextEntry = true
        element.placeholder = "senha"
        return element
    }()
    
    private lazy var loginButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.cornerRadius = 5
        element.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        element.configuration = .makeWith(backgroundColor: .init(rgb: 0xFFC13B),
                                          title: "entrar",
                                          font: .nunito(style: .regular, size: 18))
        element.configuration?.baseForegroundColor = .black
        return element
    }()
    
    private lazy var otherLoginOptionsLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = .nunito(style: .extraBold, size: 22)
        element.textColor = .black
        element.numberOfLines = 1
        element.textAlignment = .center
        element.text = "Ou entrar com:"
        return element
    }()

    private lazy var facebookLoginButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitleColor(.white, for: .normal)
        element.layer.cornerRadius = 8
        element.addTarget(self, action: #selector(didTapFacebookLogin), for: .touchUpInside)
        element.configuration = .makeWith(backgroundColor: .init(rgb: 0x4267B2),
                                          title: Strings.facebookButtonTitle,
                                          font: .nunito(style: .semiBold, size: 12),
                                          icon: Asset.Images.facebookLogo.image)
        return element
    }()

    private lazy var googleLoginButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitleColor(.white, for: .normal)
        element.layer.cornerRadius = 8
        element.addTarget(self, action: #selector(didTapGoogleLogin), for: .touchUpInside)
        element.configuration = .makeWith(backgroundColor: .init(rgb: 0xDB4437),
                                          title: Strings.googleButtonTitle,
                                          font: .nunito(style: .semiBold, size: 12),
                                          icon: Asset.Images.googleLogo.image)
        return element
    }()

    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Actions
    
    @objc
    func didTapLogin() {
        delegate?.didTapLogin(login: loginTextField.text ?? "",
                              password: passwordTextField.text ?? "")
        didTapLoginBlock?(loginTextField.text ?? "", passwordTextField.text ?? "")
    }

    @objc
    private func didTapFacebookLogin() {
        delegate?.didTapFacebookLogin()
        
        //Exemplo de chamada com clousure
        didTapFacebookLoginBlock?()
    }

    @objc
    private func didTapGoogleLogin() {
        delegate?.didTapGoogleLogin()
        
        //Exemplo de chamada com clousure
        didTapGoogleLoginBlock?()
    }
    
}

// MARK: - View Code
extension LoginView: ViewCodable {
    func buildViewHierarchy() {
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(bagsImageView)
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(otherLoginOptionsLabel)
        stackView.addArrangedSubview(facebookLoginButton)
        stackView.addArrangedSubview(googleLoginButton)

        addSubview(stackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),

            logoImageView.heightAnchor.constraint(equalToConstant: 49),
            bagsImageView.heightAnchor.constraint(equalToConstant: 106),
            loginTextField.heightAnchor.constraint(equalToConstant: 45),
            passwordTextField.heightAnchor.constraint(equalToConstant: 45),
            facebookLoginButton.heightAnchor.constraint(equalToConstant: 41),
            googleLoginButton.heightAnchor.constraint(equalToConstant: 41)
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .white
        stackView.setCustomSpacing(32, after: loginButton)
    }
}
