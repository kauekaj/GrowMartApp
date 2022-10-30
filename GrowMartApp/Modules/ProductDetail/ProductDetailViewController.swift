//
//  ProductDetailViewController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 28/10/22.
//

import UIKit

class ProductDetailViewController: BaseViewController {
    // MARK: - Private Properties
    private lazy var networkManager = NetworkManager(router: Router())

    private lazy var productDetailView: ProductDetailView = {
        let element = ProductDetailView()
        element.delegate = self
        element.translatesAutoresizingMaskIntoConstraints = true
        return element
    }()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false
        callService()
    }
    
    override func loadView() {
        super.loadView()
        view = productDetailView
    }
    
    // MARK: - Private Methods
    private func callService() {
        networkManager.execute(endpoint: ProductsApi.get(id: "1")) { [weak self] (response: Result<ProductResponse, NetworkResponse>) in
            guard let safeSelf = self else { return }
            
            switch response {
            case let .success(data):
                safeSelf.productDetailView.set(product: data)
            case .failure:
                // Apresentar estado de erro
                break
            }
        }
    }
}

// MARK: - ProfileViewDelegate
extension ProductDetailViewController: ProductDetailViewDelegate {
    func didTapAddToCart() {
        print("didTapAddToCart")
    }
    
    func didTapShare() {
        let controller = UIActivityViewController(activityItems: [
            "Olha que produto incrível encontrei no Growmart!",
            URL(string: "https://www.amazon.com.br/gp/product/B00ELBQK1W/ref=ewc_pr_img_3?smid=A1ZZFT5FULY4LN&psc=1")!
        ], applicationActivities: nil)
        controller.popoverPresentationController?.sourceView = self.view
        present(controller, animated: true, completion: nil)
    }
}
