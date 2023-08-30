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
    
}

private extension CartViewController {
    
    func initialize() {
        view.addSubview(emptyView)
        view.addSubview(cartView)
        createEmptyView()
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = popButton
    }
    
    var popButton: UIBarButtonItem {
        return UIBarButtonItem(
            image: .init(systemName: "xmark.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(popAction)
        )
    }
    
    func createCartView() {
        cartView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func createEmptyView() {
        emptyView.delegate = self
        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc
    func popAction() {
        self.popCartView()
    }
    
}

extension CartViewController: CartViewDelegate {
    
    func popCartView() {
        navigationController?.popViewController(animated: true)
    }
    
}
