//
//  ProfileViewController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 20/09/22.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    // MARK: - Private Properties
    private lazy var profileView: ProfileView = {
        let element = ProfileView()
        element.delegate = self
        return element
    }()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
    }
    
    override func loadView() {
        super.loadView()
        view = profileView
    }
    
}

// MARK: - ProfileViewDelegate

extension ProfileViewController: ProfileViewDelegate {
    
}
