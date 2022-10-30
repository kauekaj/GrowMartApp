//
//  CatalogViewController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 14/09/22.
//

import UIKit

class CatalogViewController: BaseViewController {
    // MARK: - Private Properties
    private lazy var catalogView: CatalogView = {
        let element = CatalogView()
        element.delegate = self
        return element
    }()
    
    private lazy var networkManager = NetworkManager(router: Router())
    private var products = [ProductResponse]()

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        addCartButton()
        callService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func loadView() {
        super.loadView()
        view = catalogView
    }
    
    // MARK: - Private Methods
    private func callService() {
        networkManager.execute(endpoint: ProductsApi.list(page: 1, pageSize: 20)) { [weak self] (response: Result<ProductsResponse, NetworkResponse>) in
            guard let safeSelf = self else { return }
            
            switch response {
            case let .success(data):
                guard let products = data.entries else {
                    // Apresentar estado de erro
                    return
                }
                
                safeSelf.products.append(contentsOf: products)
                safeSelf.catalogView.reloadData()
            case .failure:
                // Apresentar estado de erro
                break
            }
        }
    }
}

// MARK: - CatalogViewDelegate
extension CatalogViewController: CatalogViewDelegate {
    func numberOfItems() -> Int {
        products.count
    }
    
    func getProduct(at index: Int) -> ProductResponse? {
        guard index < products.count else {
            return nil
        }
        
        return products[index]
    }
    
    func didSelectCategory(index: Int, name: String) {
//        var url = ""
//
//        switch index {
//        case 0: url = clothesFakeUrl
//        case 1: url = acessoriesFakeUrl
//        default: url = othersFakeUrl
//        }
//
//        addFakeProducts(name: "Item categoria \(name)", imageUrl: url)
        catalogView.reloadData()
    }
    
    func didTapProduct(at index: Int) {
        navigationController?.pushViewController(ProductDetailViewController(), animated: true)
    }
}
