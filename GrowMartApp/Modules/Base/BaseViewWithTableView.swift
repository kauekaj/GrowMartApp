//
//  BaseViewWithTableView.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 30/09/22.
//

import UIKit

public class BaseViewWithTableView: BaseView {
    // MARK: - Internal Properties
    internal lazy var tableView: UITableView = {
        let element = UITableView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .white
        element.separatorStyle = .none
        return element
    }()
        
    // MARK: - Inits
    override init(shouldAddHeaderLines: Bool = true) {
        super.init(shouldAddHeaderLines: shouldAddHeaderLines)
    }

    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: - Public Methods
    
    public func setTableViewDataSource(dataSource: UITableViewDataSource?) {
        tableView.dataSource = dataSource
    }
    
    public func setTableViewDelegate(delegate: UITableViewDelegate?) {
        tableView.delegate = delegate
    }
    
    public func setupTableContentInset() {
        tableView.contentInset = .init(top: 32,
                                       left: 0,
                                       bottom: 32,
                                       right: 0)
    }
    
    // MARK: - Private Methods
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 10, right: 0)
            UIView.animate(withDuration: 0.25) {
                self.tableView.layoutIfNeeded()
                self.layoutIfNeeded()
            }
        }
    }

    @objc
    private func keyboardWillHide(notification: NSNotification) {
        setupTableContentInset()
        UIView.animate(withDuration: 0.5) {
            self.tableView.layoutIfNeeded()
            self.layoutIfNeeded()
        }
    }
}

// MARK: - Overriding ViewCodable
extension BaseViewWithTableView {
    public override func buildViewHierarchy() {
        super.buildViewHierarchy()
        addSubview(tableView)
    }
    
    public override func setupConstraints() {
        super.setupConstraints()
        
        let topAnchor = shouldAddHeaderLines ? topLineView.bottomAnchor : safeAreaLayoutGuide.topAnchor
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    public override func setupAdditionalConfiguration() {
        super.setupAdditionalConfiguration()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
}
