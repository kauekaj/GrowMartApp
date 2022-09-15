//
//  UIImageView+Extensions.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 15/09/22.
//

import UIKit

extension UIImageView {
    func addImageFromURL(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if error == nil {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                }
            }
        }.resume()
    }
}
