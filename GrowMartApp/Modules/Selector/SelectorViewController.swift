//
//  SelectorViewController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 02/09/22.
//

import UIKit

class SelectorViewController: BaseViewController {
    
    var didSelectCategoryClosure: ((_ id: String) -> Void)?
    
    // PARA EXEMPLIFICAR UMA FUNCIONALIDADE DE LOGOUT
    var logoutClosure: (() -> Void)?

    // MARK: - Private Properties
    private lazy var selectorView: SelectorView = {
        let element = SelectorView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var networkManager = NetworkManager(router: AFRouter())

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        callService()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    // MARK: - Private Methods
    private func setupView() {
        selectorView.delegate = self
        view.backgroundColor = .white
        view.addSubview(selectorView)
        navigationController?.isNavigationBarHidden = true

        NSLayoutConstraint.activate([
            selectorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            selectorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            selectorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            selectorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func renderButtons(categories: [CategoryResponse]) {
        DispatchQueue.main.async {
            self.selectorView.renderButtons(categories: categories)
        }
    }
    
    private func renderErrorState() {
        print("renderErrorState")
    }
    
    private func callService() {
        networkManager.execute(endpoint: CategoriesApi.list) { [weak self] (response: Result<CategoriesResponse, NetworkResponse>) in
            guard let safeSelf = self else { return }
            
            switch response {
            case let .success(data):
                guard let categories = data.entries else {
                    safeSelf.renderErrorState()
                    return
                }
                
                safeSelf.renderButtons(categories: categories)
            case .failure:
                safeSelf.renderErrorState()
            }
        }
    }
    
    private func getCategory(id: Int) {
        networkManager.execute(endpoint: CategoriesApi.get(id: id)) { [weak self] (response: Result<CategoryResponse, NetworkResponse>) in
            
            switch response {
            case let .success(_):
                // Mostrar os dados da categoria recuperada
                break
            case .failure:
                // Mostrar estado de erro
                break
            }
        }
    }
}

extension SelectorViewController: SelectorViewDelegate {
    func didSelectCategory(id: String) {
//        logoutClosure?()
        
        didSelectCategoryClosure?(id)
    }
}
