//
//  BaseViewController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 10/09/22.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
    }

    // MARK: - Private Methods
    private func configureNavigation() {
        guard let navigationController = navigationController else {
            return
        }

        navigationController.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem()

        let image = UIImage(named: "navigation-icon")
        let imageView = UIImageView(frame: .init(x: 0, y: 0, width: 142, height: 29))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    // MARK: - Internal Methods
    internal func addCartButton() {
        guard let image = UIImage(named: "cart")?.withRenderingMode(.alwaysOriginal) else {
            return
        }
        
        navigationItem.rightBarButtonItem = .init(image: image,
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(openCart))
    }
    
    // MARK: - Actions
    
    @objc
    private func openCart() {
        let controller = SelectorViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
