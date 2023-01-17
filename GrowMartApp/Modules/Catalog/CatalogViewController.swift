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
        setupViewModel()
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

    private func setupViewModel() {
        viewModel.loadData()
        
        viewModel.bindProductsUpdated = {
            self.catalogView.reloadData()
        }
        
        viewModel.bindFavoritesUpdated = {
            self.catalogView.reloadData()
        }
    }
    
    private func addFavorite(id: String) {
        viewModel.addFavorite(id: id)
    }
    
    private func removeFavorite(id: String) {
        viewModel.removeFavorite(id: id)
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
        
        func getProduct(at index: Int) -> ProductForCatalog? {
            viewModel.getProduct(at: index)
        }
        
        func didSelectCategory(index: Int, name: String) {
            catalogView.reloadData()
        }
        
        func didTapProduct(at index: Int) {
            navigationController?.pushViewController(ProductDetailViewController(), animated: true)
        }
        
        func isFavorite(id: String) -> Bool {
            viewModel.isFavorite(id: id)
        }
        
        func didTapFilterButton() {
            print("didTapFilterButton")
        }
    }
