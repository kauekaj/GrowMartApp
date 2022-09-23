//
//  UITableViewCell+Extensions.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 21/09/22.
//

import UIKit

extension UITableViewCell {
    public static var reuseIdentifier: String {
        String(describing: self)
    }
    
    public class func createCell<T: UITableViewCell>(for tableView: UITableView, at indexPath: IndexPath) -> T? {
        return tableView.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T
    }
}
