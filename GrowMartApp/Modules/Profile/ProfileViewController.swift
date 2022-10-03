//
//  ProfileViewController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 20/09/22.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    // MARK: - Private Properties
    private var profile: Profile = .init(name: "Michelli Cristina",
                                             address: "Rua das Flores",
                                             number: "099",
                                             complement: "00000-000",
                                             email: "teste@teste.com",
                                             cellphone: "(00) 00000-0000",
                                             canShareWhatsapp: true)
    
    private lazy var profileView: ProfileView = {
        let element = ProfileView(delegate: self,
                                          profile: profile,
                                          memberSince: "membro desde: dd/mm/yy")
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
        view = profileView
    }
    
}

// MARK: - ProfileViewDelegate

extension ProfileViewController: ProfileViewDelegate {
    func didTapProfileImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    func didTapButton() {
        let controller = EditProfileViewController()
        controller.delegate = self
        controller.profile = profile
        navigationController?.present(UINavigationController(rootViewController: controller), animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate
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

// MARK: - EditProfileViewControllerDelegate

extension ProfileViewController: EditProfileViewControllerDelegate {
    func updateProfile(data: Profile) {
        self.profile = data
        profileView.reloadData(profile: profile)
    }
}
