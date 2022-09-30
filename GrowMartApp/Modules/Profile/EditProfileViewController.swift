//
//  EditProfileViewController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 21/09/22.
//

import UIKit

protocol EditProfileViewControllerDelegate: AnyObject {
    func updateProfile(data: Profile)
}

class EditProfileViewController: BaseViewController {
    
    weak var delegate: EditProfileViewControllerDelegate?
    var profile: Profile?
    
    // MARK: - Private Properties
    private lazy var editProfileView: EditProfileView = {
        let element = EditProfileView(delegate: self,
                                      profile: profile)
        element.translatesAutoresizingMaskIntoConstraints = true
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
    func updateProfile(data: Profile) {
        delegate?.updateProfile(data: data)
        dismiss(animated: true)
    }
}
