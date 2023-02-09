//
//  ProfileView.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 20/09/22.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {
    func didTapProfileImage()
    func didTapButton()
}

public final class ProfileView: BaseView {
    // MARK: - Public Properties
    weak var delegate: ProfileViewDelegate?
    
    // MARK: - Private Properties
    
    private var profile: Profile
    private let memberSince: String?
    
    private lazy var headerView: HeaderView = {
        let element = HeaderView(title: "meu perfil",
                                 icon: Asset.Images.profile.image,
                                 roundedIcon: true)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.delegate = self
        return element
    }()
    
    private lazy var infoDataView: InfoDataView = {
        let element = InfoDataView(title: "Dados pessoais",
                                   infos: getProfileInfo(),
                                   footerMessage: memberSince)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var button: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        element.tintColor = .black
        element.setTitle("editar dados", for: .normal)
        element.setTitleColor(.black, for: .normal)
        element.configuration = .makeWith(backgroundColor: .white,
                                          font: .nunito(style: .regular, size: 18))
        element.layer.borderColor = Asset.Colors.baseYellow.color.cgColor
        element.layer.borderWidth = 1
        element.layer.cornerRadius = 5
        return element
    }()
    
    // MARK: - Inits
    init(delegate: ProfileViewDelegate?,
         profile: Profile,
         memberSince: String? = nil) {
        self.delegate = delegate
        self.profile = profile
        self.memberSince = memberSince
        super.init()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: Actions
    
    @objc
    func didTapButton() {
        delegate?.didTapButton()
    }
    
    // MARK: - Public Methods
    
    func updateProfileView(image: UIImage) {
        headerView.updateIconImageView(image: image)
    }
    
    func reloadData(profile: Profile) {
        self.profile = profile
        infoDataView.updateData(infos: getProfileInfo(),
                                footerMessage: memberSince)
    }
    
    // MARK: Private Methods
    
    private func getProfileInfo() -> [(String, String)] {
        return [
            ("nome", profile.name ?? ""),
            ("endereço", profile.address ?? ""),
            ("número", profile.number ?? ""),
            ("complemento", profile.complement ?? ""),
            ("email", profile.email ?? ""),
            ("celular", profile.cellphone ?? "")
        ]
    }
}

// MARK: - Overriding ViewCodable
extension ProfileView {
    override public func buildViewHierarchy() {
        super.buildViewHierarchy()
        
        addSubview(headerView)
        addSubview(infoDataView)
        addSubview(button)
    }

    override public func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topYellowBarView.bottomAnchor, constant: 24),
            headerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            headerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),

            infoDataView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 32),
            infoDataView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            infoDataView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            
            button.topAnchor.constraint(equalTo: infoDataView.bottomAnchor, constant: 32),
            button.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            button.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            button.heightAnchor.constraint(equalToConstant: 45)
        ])
    }

    override public func setupAdditionalConfiguration() {
        super.setupAdditionalConfiguration()
    }
}

// MARK: - HeaderViewDelegate
extension ProfileView: HeaderViewDelegate {
    func didTapIconImageView() {
        delegate?.didTapProfileImage()
    }
}
