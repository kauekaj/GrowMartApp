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
        
    }

    public func setupConstraints() {
        NSLayoutConstraint.activate([
         
        ])
    }

    public func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}


