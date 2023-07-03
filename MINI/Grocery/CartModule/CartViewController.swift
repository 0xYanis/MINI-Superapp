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
    
    private lazy var emptyView = CartEmptyView()
    private lazy var cartView = CartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presenter?.viewDidLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.hideTabBar()
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
        addView(emptyView)
        addView(cartView)
    }
    
    func addView(_ subview: UIView) {
        view.addSubview(subview)
        subview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
