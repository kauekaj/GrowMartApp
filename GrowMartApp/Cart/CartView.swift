//
//  CartView.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 03/09/22.
//

import UIKit

protocol CartViewDelegate: AnyObject {

    func numberOfRowa() -> Int

    func didTapButton()
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

    // MARK: - Private Methods

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
    }

    private func registerTableViewCells() {
        tableView.register(ButtonCell.self, forCellReuseIdentifier: String(describing: ButtonCell.self))
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CartView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        delegate?.numberOfRowa() ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ButtonCell.self), for: indexPath)

        if let buttoncell = cell as? ButtonCell {
            buttoncell.delegate = self
        }

        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CartView: ButtonCellDelegate {
    public func didTapButton() {
        print("didTapButton")
    }
    
}
