//
//  CartViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 03.07.2023.
//

import UIKit
import SnapKit

protocol CartViewProtocol: AnyObject {
    
}

final class CartViewController: UIViewController {
    var presenter: CartPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

extension CartViewController: CartViewProtocol {
    
}

private extension CartViewController {
    func initialize() {
        view.backgroundColor = .back2MINI
    }
}
