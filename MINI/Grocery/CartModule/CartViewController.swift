//
//  CartViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 03.07.2023.
//

import UIKit
import SnapKit

protocol CartViewProtocol: AnyObject {
    var cartIsEmpty: Bool { get set }
}

final class CartViewController: UIViewController {
    var presenter: CartPresenterProtocol?
    
    private lazy var emptyView = UIView()
    private lazy var cartView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presenter?.viewDidLoaded()
    }
}

extension CartViewController: CartViewProtocol {
    var cartIsEmpty: Bool {
        get {
            return emptyView.isHidden
        }
        set {
            emptyView.isHidden = !newValue
            cartView.isHidden = newValue
        }
    }
}

private extension CartViewController {
    func initialize() {
        view.backgroundColor = .back2MINI
    }
}
