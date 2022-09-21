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
    func didTapProfileImageView() {
        let controller = UIImagePickerController()
        controller.allowsEditing = false
        controller.sourceType = .photoLibrary
        controller.delegate = self
        present(controller, animated: true)
    }
    
    func didTapButton() {
//        let controller = EditProfileViewController()
//        navigationController?.present(UINavigationController(rootViewController: controller), animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            dismiss(animated: true)
            return
        }
        
        profileView.updateProfileView(image: image)
        dismiss(animated: true)
    }
}
