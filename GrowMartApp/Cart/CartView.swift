//
//  CartView.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 03/09/22.
//

import UIKit

protocol CartViewDelegate: AnyObject {

    func numberOfRows() -> Int
    func getCartCellType(at index: Int) -> CartCellType?
    func getProduct(at index: Int) -> Product?
    func getTotal() -> String
    func getButtonTitle() -> String
    func didTapButton()
    func remove(product: Product)
}

public final class CartView: UIView {
    
    // MARK: - Public Propoerties
    weak var delegate: CartViewDelegate?
    
    // MARK: - Private Propoerties
    
    private lazy var lineView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(rgb: 0xE8E8E8)
        return element
    }()
    
    private lazy var yellowBarView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(rgb: 0xFFC138)
        return element
    }()
    
    private lazy var tableView: UITableView = {
        let element = UITableView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .white
        element.dataSource = self
        element.delegate = self
        element.separatorStyle = .none
        return element
    }()
    
    // MARK: - Public Methods
    
    public func reloadTableView() {
        tableView.reloadData()
    }
    
    // MARK: - Inits
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
}

// MARK: - ViewCodable

extension CartView: ViewCodable {
    public func buildViewHierarchy() {
        addSubview(lineView)
        addSubview(yellowBarView)
        addSubview(tableView)
    }

    public func setupConstraints() {
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant:  24),
            lineView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 2),

            yellowBarView.bottomAnchor.constraint(equalTo: lineView.bottomAnchor),
            yellowBarView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            yellowBarView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant:  -32),
            yellowBarView.heightAnchor.constraint(equalToConstant: 5),

            tableView.topAnchor.constraint(equalTo: lineView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    public func setupAdditionalConfiguration() {
        backgroundColor = .white
        registerTableViewCells()
        tableView.contentInset = .init(top: 32, left: 0, bottom: 0, right: 0)
    }

    private func registerTableViewCells() {
        tableView.register(ButtonCell.self, forCellReuseIdentifier: String(describing: ButtonCell.self))
        tableView.register(TotalCell.self, forCellReuseIdentifier: String(describing: TotalCell.self))
        tableView.register(ProductCell.self, forCellReuseIdentifier: String(describing: ProductCell.self))

    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CartView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        delegate?.numberOfRows() ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cellype = delegate?.getCartCellType(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        switch cellype {
        case .product:
            guard let product = delegate?.getProduct(at: indexPath.row),
                  let cell: ProductCell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductCell.self), for: indexPath) as? ProductCell else {
                return UITableViewCell()
            }
            cell.setProduct(product)
            cell.delegate = self
            return cell
            
        case .total:
            guard let total = delegate?.getTotal(),
                  let cell: TotalCell = tableView.dequeueReusableCell(withIdentifier: String(describing: TotalCell.self), for: indexPath) as? TotalCell else {
                return UITableViewCell()
            }
            cell.setTotal(total)
            return cell
            
        case .button:
            guard let buttonTitle = delegate?.getButtonTitle(),
                  let cell: ButtonCell = tableView.dequeueReusableCell(withIdentifier: String(describing: ButtonCell.self), for: indexPath) as? ButtonCell else {
                return UITableViewCell()
            }
            
            cell.setTitle(buttonTitle, color: .black)
            cell.delegate = self
            return cell
            
        }
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - ButtonCellDelegate

extension CartView: ButtonCellDelegate {
    public func didTapButton() {
        delegate?.didTapButton()
    }
}

// MARK: - ProductCellDelegate

extension CartView: ProductCellDelegate {
    public func remove(product: Product) {
        delegate?.remove(product: product)
    }
}
