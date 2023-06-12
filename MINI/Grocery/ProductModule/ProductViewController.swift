//
//  ProductViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 12.06.2023.
//

import UIKit
import SnapKit

protocol ProductViewProtocol: AnyObject {
    func updateView()
}

final class ProductViewController: UIViewController {
    
    var presenter: ProductPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
        initialize()
    }
    
}

extension ProductViewController: ProductViewProtocol {
    func updateView() {
        createNavigaion(with: "Product")
    }
}

private extension ProductViewController {
    func initialize() {
        view.backgroundColor = .black
    }
    
    func createNavigaion(with title: String) {
        navigationItem.title = title
    }
}
