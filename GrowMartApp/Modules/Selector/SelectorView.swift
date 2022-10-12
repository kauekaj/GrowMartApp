//
//  SelectorView.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 02/09/22.
//

import UIKit

public protocol SelectorViewDelegate: AnyObject {
    func didSelectCategory(id: String)
}

class SelectorView: BaseViewWithTableView {

    // MARK: - Public Properties
    weak var delegate: SelectorViewDelegate?

    // MARK: - Private Properties
    private var categories: [CategoryResponse] = []

    // MARK: - Public Methods
    
    func renderButtons(categories: [CategoryResponse]) {
        viewState = .loaded
        self.categories = categories
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
        
    // MARK: - Inits
    override init(shouldAddHeaderLines: Bool = false) {
        super.init(shouldAddHeaderLines: shouldAddHeaderLines)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Actions
    @objc
    private func didTapButton(_ sender: UITapGestureRecognizer) {
        guard let button = sender.view as? CategoryButton else { return }
        delegate?.didSelectCategory(id: button.categoryId ?? "")
    }
    
    // MARK: - Private Methods
    private func registerTableViewCells() {
        tableView.register(CategoryButtonCell.self, forCellReuseIdentifier: CategoryButtonCell.reuseIdentifier)
        tableView.register(LoadingCell.self, forCellReuseIdentifier: LoadingCell.reuseIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)

    }
}

// MARK: - View Code Overrides

extension SelectorView {

    override func setupAdditionalConfiguration() {
        super.setupAdditionalConfiguration()
        setTableViewDelegate(delegate: self)
        setTableViewDataSource(dataSource: self)
        registerTableViewCells()
        setupTableContentInset()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension SelectorView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewState == .loaded ? categories.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewState == .loaded {
            guard let cell: CategoryButtonCell = .createCell(for: tableView, at: indexPath) else {
                return UITableViewCell()
            }
            
            return cell
            
//            let category = categories[indexPath.row]
//            cell.setData(categoryId: category.id ?? "",
//                         title: category.name?.capitalized ?? "",
//                         imageSide: indexPath.row % 2 == 0 ? .right : .left,
//                         imageUrl: category.image)
//            cell.delegate = self
//            return cell
        } else {
            guard let cell: LoadingCell = .createCell(for: tableView, at: indexPath) else {
                return UITableViewCell()
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.nunito(style: .extraBold, size: 30)
        label.textColor = UIColor(rgb: 0x1E3D59)
        label.text = "O que você quer comprar?"
        label.numberOfLines = 0
        label.textAlignment = .left
        
        headerView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: headerView.topAnchor),
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 60),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -60),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -60)
        ])

        return headerView
    }
}

// MARK: - CategoryButtonCellDelegate
extension SelectorView: CategoryButtonCellDelegate {
    func didTapCategoryButton(categoryId: String) {
        delegate?.didSelectCategory(id: categoryId)
    }
}
