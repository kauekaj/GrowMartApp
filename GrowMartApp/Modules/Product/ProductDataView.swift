//
//  ProductDataView.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 30/09/22.
//

import UIKit

protocol ProductDataViewDelegate: AnyObject {
    func addProduct(_ product: Product)
    func didTapAddPhotoButton()
    func didTapPhoto(at index: Int)
}

public final class ProductDataView: BaseViewWithTableView {
    
    // MARK: - Public Properties
    weak var delegate: ProductDataViewDelegate?
    
    // MARK: - Private Properties
    private var product = Product()
    private var values: [(field: Product.Field, value: Any)] = []
    private var cells: [CellType] = []
    
    // MARK: - Inits
    init(delegate: ProductDataViewDelegate?) {
        super.init()
        self.delegate = delegate
        setupView()
        setupValues()
        setupCells()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: - Private Methods
    private func registerTableViewCells() {
        tableView.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.reuseIdentifier)
        tableView.register(SimpleTextfieldCell.self, forCellReuseIdentifier: SimpleTextfieldCell.reuseIdentifier)
        tableView.register(SelectorCell.self, forCellReuseIdentifier: SelectorCell.reuseIdentifier)
    }
    
    private func cellType(for index: IndexPath) -> CellType? {
        guard index.row < cells.count else {
            return nil
        }
        
        return cells[index.row]
    }
    
    private func setupValues() {
        values = [
            (field: .name, value: product.name ?? ""),
            (field: .price, value: product.price ?? ""),
            (field: .category, value: product.category ?? ""),
            (field: .size, value: product.size ?? ""),
            (field: .condition, value: product.condition ?? ""),
            (field: .brand, value: product.brand ?? ""),
            (field: .description, value: product.description ?? "")
        ]
    }
    
    private func setupCells() {
        cells.removeAll()
        values.forEach { item in
            if let cellType: CellType = .getCellType(from: item.field) {
                cells.append(cellType)
            }
        }
        cells.append(.button)
    }
    
    private func updateProduct(field: Product.Field, value: Any?) {
        switch field {
        case .name:
            product.name = value as? String
        case .price:
            product.price = value as? String
        case .category:
            product.category = value as? String
        case .size:
            product.size = value as? String
        case .condition:
            product.condition = value as? String
        case .brand:
            product.brand = value as? String
        case .description:
            product.description = value as? String
        }
    }
    
    private func getFieldValue(field: Product.Field) -> Any? {
        switch field {
        case .name:
            return product.name
        case .price:
            return product.price
        case .category:
            return product.category
        case .size:
            return product.size
        case .condition:
            return product.condition
        case .brand:
            return product.brand
        case .description:
            return product.description
        }
    }
    
    private func getOptions(field: Product.Field) -> [String] {
        switch field {
        case .condition:
            return ["Novo", "Usado"]
        case .category:
            return ["Roupas", "Acessórios", "Outros"]
        default:
            return []
        }
    }
}

// MARK: - TableView cell types
extension ProductDataView {
    private enum CellType {
        case photos([Photo])
        case textField(Product.Field)
        case selector(Product.Field)
        case button
        
        static func getCellType(from field: Product.Field) -> CellType? {
            switch field {
            case .category, .condition:
                return .selector(field)
            default:
                return .textField(field)
            }
        }
    }
}

// MARK: - Overriding ViewCodable
extension ProductDataView {
    
    public override func setupAdditionalConfiguration() {
        super.setupAdditionalConfiguration()
        setTableViewDelegate(delegate: self)
        setTableViewDataSource(dataSource: self)
        registerTableViewCells()
        setupTableContentInset()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ProductDataView: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = cellType(for: indexPath) else {
            return UITableViewCell()
        }
        
        switch cellType {
        case let .photos(photos):
            guard let cell: CarouselPhotosCell = .createCell(for: tableView, at: indexPath) else {
                return UITableViewCell()
            }
            cell.delegate = self
            return cell
        case let .textField(field):
            guard let cell: SimpleTextfieldCell = .createCell(for: tableView, at: indexPath) else {
                return UITableViewCell()
            }
            
            cell.propertyName = field.rawValue
            cell.delegate = self
            cell.setData(placeholder: field.getFormattedName(),
                         value: getFieldValue(field: field) as? String)
            return cell
        case let .selector(field):
            guard let cell: SelectorCell = .createCell(for: tableView, at: indexPath) else {
                return UITableViewCell()
            }
            
            cell.propertyName = field.rawValue
            cell.delegate = self
            cell.setData(placeholder: field.getFormattedName(),
                         value: getFieldValue(field: field) as? String,
                         options: getOptions(field: field))
            return cell
        case .button:
            guard let cell: ButtonCell = .createCell(for: tableView, at: indexPath) else {
                return UITableViewCell()
            }
            
            cell.setTitle("publicar", color: .black)
            cell.delegate = self
            return cell
        }
    }
}

// MARK: - ButtonCellDelegate
extension ProductDataView: ButtonCellDelegate {
    public func didTapButton() {
        print("didTapButton")
    }
}

// MARK: - TextFieldCellDelegate & DoubleTextFieldCellDelegate
extension ProductDataView: SimpleTextfieldCellDelegate, SelectorCellDelegate {
    public func didChangeValue(propertyName: String?, value: String) {
        guard let propertyName = propertyName,
              let field = Product.Field(rawValue: propertyName) else {
            return
        }
        
        updateProduct(field: field, value: value)
    }
}

extension ProductDataView: CarouselPhotosCellDelegate {
    public func didTapAddPhotoButton() {
        endEditing(true)
        delegate?.didTapAddPhotoButton()
    }
    
    public func didTapPhoto(at index: Int) {
        delegate?.didTapPhoto(at: index)
    }
}
