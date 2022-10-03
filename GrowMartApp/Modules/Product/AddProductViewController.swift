//
//  AddProductViewController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 30/09/22.
//

import UIKit

class AddProductViewController: BaseViewController {
    // MARK: - Private Properties
    private lazy var productDataView: ProductDataView = {
        let element = ProductDataView(delegate: self)
        element.translatesAutoresizingMaskIntoConstraints = true
        return element
    }()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false
    }
    
    override func loadView() {
        super.loadView()
        view = productDataView
    }
}

// MARK: - EditProfileViewDelegate

extension AddProductViewController {
    
    private func openGallery() {
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.allowsEditing = false
        imagePickerViewController.sourceType = .photoLibrary
        imagePickerViewController.delegate = self
        present(imagePickerViewController, animated: true, completion: nil)
    }
    
    private func confirmPhotoDeletion(index: Int) {
        let confirmAlert = UIAlertController(title: "Atenção!",
                                             message: "Deseja realemente remover esta foto?",
                                             preferredStyle: .alert)
        confirmAlert.addAction(.init(title: "OK", style: .default, handler: { [weak self] _ in
            self?.productDataView.removePhoto(index: index)
        }))
        
        confirmAlert.addAction(.init(title: "Cancelar", style: .cancel, handler: nil))
        
        present(confirmAlert, animated: true, completion: nil)
    }

}

// MARK: - EditProfileViewDelegate
extension AddProductViewController: ProductDataViewDelegate {
    func addProduct(_ product: Product) {
        
    }
    func didTapAddPhotoButton() {
        openGallery()
    }
    
    func didTapPhoto(at index: Int) {
        confirmPhotoDeletion(index: index)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension AddProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            dismiss(animated: true, completion: nil)
            return
        }
        
        productDataView.addPhotos(image: image)
        dismiss(animated: true, completion: nil)
    }
}
