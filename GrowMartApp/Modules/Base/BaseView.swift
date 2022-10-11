//
//  BaseView.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 27/09/22.
//

import UIKit

enum ViewState {
    case loading
    case error
    case empty
    case loaded
}

public class BaseView: UIView {
    // MARK: - Internal Properties
    internal var shouldAddHeaderLines: Bool
    internal var viewState: ViewState = .loading
    
    internal lazy var topLineView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(rgb: 0xE8E8E8)
        return element
    }()
    
    internal lazy var topYellowBarView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(rgb: 0xFFC13B)
        return element
    }()
    
    // MARK: - Inits
    init(shouldAddHeaderLines: Bool = true) {
        self.shouldAddHeaderLines = shouldAddHeaderLines
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
}

// MARK: - ViewCodable
extension BaseView: ViewCodable {
    @objc
    public func buildViewHierarchy() {
        if shouldAddHeaderLines {
            addSubview(topLineView)
            addSubview(topYellowBarView)
        }
    }
    
    @objc
    public func setupConstraints() {
        if shouldAddHeaderLines {
            NSLayoutConstraint.activate([
                topLineView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
                topLineView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                topLineView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                topLineView.heightAnchor.constraint(equalToConstant: 2),
                
                topYellowBarView.bottomAnchor.constraint(equalTo: topLineView.bottomAnchor),
                topYellowBarView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
                topYellowBarView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
                topYellowBarView.heightAnchor.constraint(equalToConstant: 5)
            ])
        }
    }
    
    @objc
    public func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}
