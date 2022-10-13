//
//  SelectorViewController.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 02/09/22.
//

import UIKit
import Alamofire

class SelectorViewController: BaseViewController {
    // MARK: - Internal Properties
    private lazy var selectorView: SelectorView = {
        let element = SelectorView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
//        callAPI(url: "https://growmart-api.herokuapp.com/v1/categories") { [weak self] response in
//            self?.selectorView.renderButtons(categories: response?.entries ?? [])
//        }
        callAPIMock() { [weak self] response in
            self?.selectorView.renderButtons(categories: response?.entries ?? [])
        }
        
    }
    
    func callAPIMock(completion: @escaping (CategoriesResponse?) -> Void) {
        
        guard let path = Bundle.main.path(forResource: "Categories", ofType: "json") else {
            fatalError("Mock not found")
        }
        
        let urlRequest = NSURL.fileURL(withPath: path)
        URLSession.shared.dataTask(with: URLRequest(url: urlRequest),
                                   completionHandler: { data, _, _ in
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(CategoriesResponse.self, from: data)
                completion(result)
            } catch (let error) {
                print(error)
                completion(nil)
            }
        }).resume()
        
    }
    
    func callAPI(url: String, completion: @escaping (CategoriesResponse?) -> Void) {
        
        guard let urlRequest = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: URLRequest(url: urlRequest),
                                   completionHandler: { data, _, _ in
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(CategoriesResponse.self, from: data)
                completion(result)
            } catch (let error) {
                print(error)
                completion(nil)
            }
        }).resume()
    }

    func callAlamofire() {
        
        guard let url = URL(string: "https://growmart-api.herokuapp.com/v1/categories") else { return }
        
        AF.request(url,
                   method: .get,
                   headers: []).response { response in
            guard let data = response.data else { return }
            
            do {
                let result = try JSONDecoder().decode(CategoriesResponse.self, from: data)
                print(result)
            } catch (let error) {
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    // MARK: - Private Methods
}

extension SelectorViewController: ViewCodable {
    func buildViewHierarchy() {
        view.addSubview(selectorView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            selectorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            selectorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            selectorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            selectorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
        selectorView.delegate = self
    }
}

extension SelectorViewController: SelectorViewDelegate {
    func didSelectCategory(id: String) {
        let controller = CatalogViewController()
        navigationController?.pushViewController(controller, animated: true)

        }
}
