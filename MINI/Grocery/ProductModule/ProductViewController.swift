//
//  ProductViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 12.06.2023.
//

import UIKit
import SnapKit

protocol ProductViewProtocol: AnyObject {
    
}

final class ProductViewController: UIViewController {
    
    var presenter: ProductPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
}

extension ProductViewController: ProductViewProtocol {
    
}

private extension ProductViewController {
    func initialize() {
        view.backgroundColor = .black
    }
}
