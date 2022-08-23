//
//  ViewController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 22/08/22.
//

import UIKit

class LoginController: UIViewController {

    // MARK: - Private Properties
    private lazy var stackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .vertical
        element.spacing = 27
        return element
    }()

    private lazy var logoImageView: UIImageView = {
       let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFit
        element.image = UIImage(named: "growmart")
        return element
    }()

    private lazy var bagsImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFit
        element.image = UIImage(named: "sacolas")
        return element
    }()

    private lazy var facebookButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitleColor(.white, for: .normal)
        return element
    }()

    private lazy var youtubeButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitleColor(.white, for: .normal)

        return element
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
    }

}
