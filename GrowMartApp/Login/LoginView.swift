//
//  LoginView.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 23/08/22.
//

import UIKit

public protocol LoginViewDelegate: AnyObject {
    func openFacebookLogin()
    func openGoogleLogin()
}

class LoginView: UIView {
    // MARK: - Public Properties
    weak var delegate: LoginViewDelegate?

    // MARK: - Private Properties
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 27
        return stackView
    }()

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "growmart")
        return imageView
    }()

    private lazy var bagsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "sacolas")
        return imageView
    }()

    private lazy var facebookLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(didTapFacebookLogin), for: .touchUpInside)
        button.configuration = getButtonConfigurations(backgroundColor: .init(rgb: 0x4267B2),
                                                       title: "ENTRAR COM FACEBOOK",
                                                       icon: UIImage(named: "facebook-logo"))
        return button
    }()

    private lazy var googleLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.setImage(UIImage(named: "google-logo"), for: .normal)
        button.addTarget(self, action: #selector(didTapGoogleLogin), for: .touchUpInside)
        button.configuration = getButtonConfigurations(backgroundColor: .init(rgb: 0xDB4437),
                                                       title: "ENTRAR COM GOOGLE",
                                                       icon: UIImage(named: "google-logo"))
        return button
    }()

    // MARK: - Private Methods
    private func getButtonConfigurations(backgroundColor: UIColor,
                                         title: String,
                                         icon: UIImage?) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.attributedTitle = AttributedString(title, attributes: getFontAttributes())
        configuration.image = icon
        configuration.titlePadding = 10
        configuration.imagePadding = 30
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        configuration.background.backgroundColor = backgroundColor
        return configuration
    }

    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func getFontAttributes() -> AttributeContainer {
        AttributeContainer([NSAttributedString.Key.font : UIFont.nunito(style: .semiBold, size: 12)])
    }

    // MARK: - Actions

    @objc
    private func didTapFacebookLogin() {
        delegate?.openFacebookLogin()
    }

    @objc
    private func didTapGoogleLogin() {
        delegate?.openGoogleLogin()
    }
}

// MARK: - View Code
extension LoginView: ViewCodable {
    func setupView() {
        backgroundColor = .white
        buildViewHierarchy()
        setupConstraints()
    }

    func buildViewHierarchy() {
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(bagsImageView)
        stackView.addArrangedSubview(facebookLoginButton)
        stackView.addArrangedSubview(googleLoginButton)
        stackView.setCustomSpacing(16, after: facebookLoginButton)

        addSubview(stackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),

            logoImageView.heightAnchor.constraint(equalToConstant: 49),
            bagsImageView.heightAnchor.constraint(equalToConstant: 106),
            facebookLoginButton.heightAnchor.constraint(equalToConstant: 41),
            googleLoginButton.heightAnchor.constraint(equalToConstant: 41)
        ])
    }
}
