//
//  EditProfileViewController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 21/09/22.
//

import UIKit

class EditProfileViewController: BaseViewController {
    
    // MARK: - Private Properties
    private lazy var editProfileView: EditProfileView = {
        let element = EditProfileView(delegate: self,
                                      profile: .init())
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
        view = editProfileView
    }
    
    // MARK: - Private Methods
}

// MARK: - EditProfileViewDelegate
extension EditProfileViewController: EditProfileViewDelegate {

}
