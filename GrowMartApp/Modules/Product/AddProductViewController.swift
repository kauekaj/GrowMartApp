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
extension AddProductViewController: ProductDataViewDelegate {
    func addProduct(_ product: Product) {
        
    }
}
