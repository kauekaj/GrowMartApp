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
        private var products = [Product]()
        
        private let clothesUrl = "https://fjallraven.vteximg.com.br/arquivos/ids/156206-751-936/F87314620_Camiseta_Masculina_Tornetrask_T-shirt_M_front_1.png"
        private let acessoriesUrl = "https://secure-static.arezzo.com.br/medias/sys_master/arezzo/arezzo/h79/h77/h00/h00/10406142246942/5002305310001U-01-BASEIMAGE-Midres.jpg"
        private let othersUrl = "https://www.mariapiacasa.com.br/media/catalog/product/cache/1/image/0dc2d03fe217f8c83829496872af24a0/t/o/toca-discos-vinil-retro-dallas-classic-35309-1.jpg"

        // MARK: - View Life Cycle
        
        override func viewDidLoad() {
            super.viewDidLoad()
            navigationController?.isNavigationBarHidden = false
            
            addFakeProducts(name: "Item categoria roupas", imageUrl: clothesUrl)
            //catalogView.reloadData()
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
        private func addFakeProducts(name: String, imageUrl: String) {
            products.removeAll()
            for index in 0...20 {
                products.append(.init(name: "\(name) \(index)",
                                      price: "R$ 99.99",
                                      imageUrl: imageUrl))
            }
        }
    }

    // MARK: - CatalogViewDelegate
    extension CatalogViewController: CatalogViewDelegate {
        func numberOfItems() -> Int {
            products.count
        }
        
        func getProduct(at index: Int) -> Product? {
            guard index < products.count else {
                return nil
            }
            
            return products[index]
        }
        
        func didTapButtonClothes() {
            
        }
        
        func didTapButtonAcessories() {
            
        }
        
        func didTapButtonOthers() {
            
        }
        
        func didTapProduct(at index: Int) {
            navigationController?.pushViewController(CartViewController(), animated: true)
        }
    }
 
