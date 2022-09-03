//
//  CartView.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 03/09/22.
//

import UIKit

protocol CartViewDelegate: AnyObject {
    
}

public final class CartView: UIView {
    
    // MARK: - Private Propoerties
    
    private lazy var lineView: UIView = {
       let element = UIView()
        
        
        return element
    }()
    
    
    // MARK: - Private Methods

    
    
    // MARK: - Inits
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
}
