//
//  CartViewController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 06/09/22.
//

import UIKit

class CartViewController: UIViewController {

    private var cartView: CartView?

    override func loadView() {
        super.loadView()

        cartView = .init()
        view = cartView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension CartViewController: CartViewDelegate {
    func didTapButton() {
        print("didTapButton")
    }

}
