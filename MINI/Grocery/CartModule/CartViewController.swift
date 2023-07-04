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
    
    private lazy var backButton = UIButton(
        systemImage: "xmark.circle.fill",
        color: .tintMINI,
        size: 35
    )
    
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
        navigationItem.setHidesBackButton(
            true,
            animated: true
        )
        view.backgroundColor = .back2MINI
        addView(emptyView)
        addView(cartView)
        
        cartView.delegate = self
        emptyView.delegate = self
        
        createBackButton()
    }
    
    func addView(_ subview: UIView) {
        view.addSubview(subview)
        subview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func createBackButton() {
        view.insertSubview(backButton, at: 1)
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(additionalSafeAreaInsets.top)
            make.right.equalToSuperview().inset(25)
        }
        backButton.addTarget(
            self,
            action: #selector(backButtonAction),
            for: .touchUpInside
        )
    }
    
    @objc func backButtonAction() {
        navigationController?.popViewController(animated: false)
    }
}

extension CartViewController: CartViewDelegate {
    func popCartView() {
        navigationController?.popViewController(animated: false)
    }
}
