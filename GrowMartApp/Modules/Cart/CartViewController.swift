//
//  CartViewController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 06/09/22.
//

import UIKit

public enum CartCellType {
    case product
    case total
    case button
}

struct CartCell {
    let cellType: CartCellType
    let data: Any?
}

class CartViewController: BaseViewController {

    private var cartView: CartView?

    private var cells: [CartCell] = [
            .init(cellType: .product, data: Product(name:"título produto 1", price:"R$ 0,00", imageUrl: "produto-exemplo")),
            .init(cellType: .product, data: Product(name:"título produto 2", price:"R$ 0,00", imageUrl: "produto-exemplo")),
            .init(cellType: .product, data: Product(name:"título produto 3", price:"R$ 0,00", imageUrl: "produto-exemplo")),
//            .init(cellType: .product, data: Product(name:"título produto 4", price:"R$ 0,00", imageUrl: "produto-exemplo")),
//            .init(cellType: .product, data: Product(name:"título produto 5", price:"R$ 0,00", imageUrl: "produto-exemplo")),
//            .init(cellType: .product, data: Product(name:"título produto 6", price:"R$ 0,00", imageUrl: "produto-exemplo")),
//            .init(cellType: .product, data: Product(name:"título produto 7", price:"R$ 0,00", imageUrl: "produto-exemplo")),
//            .init(cellType: .product, data: Product(name:"título produto 8", price:"R$ 0,00", imageUrl: "produto-exemplo")),
//            .init(cellType: .product, data: Product(name:"título produto 9", price:"R$ 0,00", imageUrl: "produto-exemplo")),
//            .init(cellType: .product, data: Product(name:"título produto 10", price:"R$ 0,00", imageUrl: "produto-exemplo")),
            .init(cellType: .total, data: "total: R$ 0.00"),
            .init(cellType: .button, data: "check-out")
        ]

    override func loadView() {
        super.loadView()

        cartView = .init()
        view = cartView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        cartView?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

}

extension CartViewController: CartViewDelegate {
    func numberOfRows() -> Int {
        cells.count
    }

    func getCartCellType(at index: Int) -> CartCellType? {
        guard index < cells.count else {
            return nil
        }

        return cells[index].cellType
    }

    func getProduct(at index: Int) -> Product? {
        guard let product = cells[index].data as? Product else {
            return nil
        }

        return product
    }

    func getTotal() -> String {
        guard let total = cells.first(where: { $0.cellType == .total })?.data as? String else {
            return ""
        }

        return total
    }

    func getButtonTitle() -> String {
        guard let buttonTitle = cells.first(where: { $0.cellType == .button })?.data as? String else {
            return ""
        }

        return buttonTitle
    }

    func didTapButton() {
        print("didTapButton")
    }

    func remove(product: Product) {
        print("Removeu o produto: \(product.name)")

        cells.removeAll { cell in
            if let productCell = cell.data as? Product {
                return productCell.name == product.name
            }
            return false
        }
        cartView?.reloadTableView()
    }
}
