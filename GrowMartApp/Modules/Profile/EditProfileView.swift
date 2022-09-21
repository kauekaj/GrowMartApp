//
//  EditProfileView.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 21/09/22.
//

import UIKit

protocol EditProfileViewDelegate: AnyObject {

}

public final class EditProfileView: UIView {
    // MARK: - Public Properties
    weak var delegate: EditProfileViewDelegate?
    
    // MARK: - Private Properties
    private var profile: Profile?
    private var values: [(field: Profile.Field, value: Any)] = []
    private var cells: [CellType] = []
    
    private lazy var lineView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(rgb: 0xE8E8E8)
        return element
    }()
    
    private lazy var yellowBarView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(rgb: 0xFFC13B)
        return element
    }()
    
    private lazy var tableview: UITableView = {
        let element = UITableView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .white
        element.dataSource = self
        element.delegate = self
        element.separatorStyle = .none
        return element
    }()

    // MARK: - Inits
    init(delegate: EditProfileViewDelegate?, profile: Profile) {
        self.delegate = delegate
        self.profile = profile
        super.init(frame: .zero)
        setupView()
        setupValues()
        setupCells()
    }

    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: - Private Methods
    
    private func registerTableViewCells() {
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        tableview.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.reuseIdentifier)
//        tableview.register(CheckboxCell.self, forCellReuseIdentifier: CheckboxCell.reuseIdentifier)
//        tableview.register(TextFieldCell.self, forCellReuseIdentifier: TextFieldCell.reuseIdentifier)
//        tableview.register(DoubleTextFieldCell.self, forCellReuseIdentifier: DoubleTextFieldCell.reuseIdentifier)
    }
    
    private func cellType(for index: IndexPath) -> CellType? {
        guard index.row < cells.count else {
            return nil
        }
        
        return cells[index.row]
    }
    
    private func setupValues() {
        values = [
            (field: .name, value: profile?.name ?? ""),
            (field: .address, value: profile?.address ?? ""),
            (field: .number, value: profile?.number ?? ""),
            (field: .complement, value: profile?.complement ?? ""),
            (field: .email, value: profile?.email ?? ""),
            (field: .cellphone, value: profile?.cellphone ?? ""),
            (field: .canShareWhatsapp, value: profile?.canShareWhatsapp ?? false)
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
    
    private func updateProfile(field: Profile.Field, value: Any?) {
        switch field {
        case .name:
            profile?.name = value as? String
        case .address:
            profile?.address = value as? String
        case .number:
            profile?.number = value as? String
        case .complement:
            profile?.complement = value as? String
        case .email:
            profile?.email = value as? String
        case .cellphone:
            profile?.cellphone = value as? String
        case .canShareWhatsapp:
            profile?.canShareWhatsapp = value as? Bool
        }
    }
}

// MARK: - ViewCodable
extension EditProfileView: ViewCodable {
    public func buildViewHierarchy() {
        addSubview(lineView)
        addSubview(yellowBarView)
        addSubview(tableview)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            lineView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 2),

            yellowBarView.bottomAnchor.constraint(equalTo: lineView.bottomAnchor),
            yellowBarView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            yellowBarView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            yellowBarView.heightAnchor.constraint(equalToConstant: 5),
            
            tableview.topAnchor.constraint(equalTo: lineView.bottomAnchor),
            tableview.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    public func setupAdditionalConfiguration() {
        backgroundColor = .white
        registerTableViewCells()
        tableview.contentInset = .init(top: 32, left: 0, bottom: 32, right: 0)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension EditProfileView: UITableViewDataSource, UITableViewDelegate {
    private enum CellType {
        case textField(Profile.Field)
        case doubleTextField(Profile.Field, Profile.Field)
        case checkbox(Profile.Field)
        case button
        
        static func getCellType(from field: Profile.Field) -> CellType? {
            switch field {
            case .name, .address, .email, .cellphone:
                return .textField(field)
            case .number:
                return .doubleTextField(.number, .complement)
            case .complement:
                return nil
            case .canShareWhatsapp:
                return .checkbox(field)
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return .init()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let header = HeaderView(title: "editar perfil",
                                icon: UIImage(named: "edit-profile"))
        header.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(header)
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),

            header.topAnchor.constraint(equalTo: view.topAnchor),
            header.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])

        return view
    }
}
