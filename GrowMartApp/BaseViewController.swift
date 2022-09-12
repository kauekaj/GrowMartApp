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
}
