//
//  ProfileView.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 20/09/22.
//

import UIKit

public protocol ProfileViewDelegate: AnyObject {
    
}

class ProfileView: UIView {
    
    // MARK: - Public Properties
    weak var delegate: ProfileViewDelegate?
    
    // MARK: - Private Properties
    
    private lazy var lineView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(rgb: 0xE8E8E8)
        return element
    }()
    
    private lazy var yellowBarView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(rgb: 0xFFC138)
        return element
    }()
    
//    private lazy var headerView: HeaderView = {
//        let element = HeaderView(title: "meu perfil",
//                                 icon: UIImage(named: "profile"),
//                                 roundedIcon: true)
//        element.translatesAutoresizingMaskIntoConstraints = false
//        element.delegate = self
//        return element
//    }()
    
//    private lazy var profileDataView: InfoDataView = {
//        let element = InfoDataView(title: "Dados pessoais",
//                                   infos: [
//                                    ("nome", "Michelli Cristina"),
//                                    ("celular", "(00) 00000-0000")
//                                   ],
//                                   footerMessage: "membro desde: dd/mm/yy")
//        element.translatesAutoresizingMaskIntoConstraints = false
//        return element
//    }()
    
    private lazy var button: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        //element.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        element.tintColor = .black
        element.setTitleColor(.black, for: .normal)
//        element.configuration = .makeWith(backgroundColor: .white,
//                                          font: .nunito(style: .regular, size: 18))
        element.layer.borderColor = UIColor(rgb: 0xFFC13B).cgColor
        element.layer.borderWidth = 1
        element.layer.cornerRadius = 5
        return element
    }()
    
    // MARK: - Inits
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

extension ProfileView: ViewCodable {
    public func buildViewHierarchy() {
        addSubview(lineView)
        addSubview(yellowBarView)
//        addSubview(headerView)
//        addSubview(profileDataView)
        addSubview(button)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            lineView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 2),
            
            yellowBarView.bottomAnchor.constraint(equalTo: lineView.bottomAnchor),
            yellowBarView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            yellowBarView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            yellowBarView.heightAnchor.constraint(equalToConstant: 5),
            
            yellowBarView.bottomAnchor.constraint(equalTo: lineView.bottomAnchor),
            yellowBarView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            yellowBarView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            yellowBarView.heightAnchor.constraint(equalToConstant: 5),
            
            yellowBarView.bottomAnchor.constraint(equalTo: lineView.bottomAnchor),
            yellowBarView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            yellowBarView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            yellowBarView.heightAnchor.constraint(equalToConstant: 5),
//            headerView.topAnchor.constraint(equalTo: yellowBarView.bottomAnchor, constant: 24),
//            headerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
//            headerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
//
//            profileDataView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 32),
//            profileDataView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
//            profileDataView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
//
//            button.topAnchor.constraint(equalTo: profileDataView.bottomAnchor, constant: 32),
//            button.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
//            button.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
//            button.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    public func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}

