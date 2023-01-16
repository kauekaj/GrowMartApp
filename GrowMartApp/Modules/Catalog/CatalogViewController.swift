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
    
    private let viewModel: CatalogViewModel = .init()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        addCartButton()
        loadFavorites()
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
        
    
 
    
    private func addFavorite(id: String) {
//        guard let product = products.first(where: { $0.id == id }) else {
//            return
//        }
//
//        DataManager.shared.addFavorite(product)
    }
    
    private func removeFavorite(id: String) {
//        DataManager.shared.removeFavorite(id: id)
    }
    
}
    // MARK: - CatalogViewDelegate

    extension CatalogViewController: CatalogViewDelegate {
        func didTapFavorite(id: String, isFavorite: Bool) {
            if isFavorite {
                addFavorite(id: id)
            } else {
                removeFavorite(id: id)
            }
        }
        
        func numberOfItems() -> Int {
            viewModel.getNumberOfItems()
        }
        
        func getProduct(at index: Int) -> ProductResponse? {
//            guard index < products.count else {
//                return nil
//            }
//
//            return products[index]
            
            viewModel.getProduct(at: index)

        }
        
        func didSelectCategory(index: Int, name: String) {
            catalogView.reloadData()
        }
        
        func didTapProduct(at index: Int) {
            navigationController?.pushViewController(ProductDetailViewController(), animated: true)
        }
        
        func isFavorite(id: String) -> Bool {
//            favorites.compactMap { $0.identifier }.contains(id)
            
            viewModel.isFavorite(id: id)
        }
        
        func didTapFilterButton() {
            print("didTapFilterButton")
        }
    }
