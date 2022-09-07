//
//  SelectorViewController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 02/09/22.
//

import UIKit

class SelectorViewController: UIViewController {
    // MARK: - Internal Properties
    private lazy var selectorView: SelectorView = {
        let element = SelectorView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Methods
}

extension SelectorViewController: ViewCodable {
    func buildViewHierarchy() {
        view.addSubview(selectorView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            selectorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            selectorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            selectorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            selectorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
        selectorView.delegate = self
    }
}

extension SelectorViewController: SelectorViewDelegate {
    func didSelectCategory(id: Int) {
            print("Category \(id)")

        let controller = CartViewController()
        navigationController?.pushViewController(controller, animated: true)

        }
}
