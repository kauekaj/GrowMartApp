//
//  UICollectionViewCell.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 03/10/22.
//

import UIKit

extension UICollectionViewCell {
    public static var reuseIdentifier: String {
        String(describing: self)
    }
    
    public class func createCell<T: UICollectionViewCell>(for collectionView: UICollectionView, at indexPath: IndexPath) -> T? {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T
    }
}
