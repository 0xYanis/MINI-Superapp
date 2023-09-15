//
//  CartViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 05.09.2023.
//

import UIKit
import FloatingPanel

protocol CartViewProtocol: AnyObject {
    
}

final class CartViewController: UIViewController {
    
    // MARK: - Public properties
    
    public var presenter: CartPresenterProtocol?
    
    // MARK: - Private properties
    
    private let tableView = CartTableView()
    private lazy var emptyView = EmptyPayoutsView()
    private lazy var floatingPanel = FloatingPanelController()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.showTabBar()
    }
    
}

// MARK: - CartViewProtocol

extension CartViewController: CartViewProtocol {
    
}

// MARK: - Private methods

private extension CartViewController {
    
    func initialize() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem  = clearButton
        navigationItem.rightBarButtonItem = shareButton
        view.backgroundColor = .secondarySystemBackground
        navigationItem.title = "Корзина"
        checkCurrentState()
    }
    
    func checkCurrentState() {
        guard
            let purchases = presenter?.getPurchases(),
            purchases.isEmpty != true
        else { showEmptyView(); return }
        configureTableView()
    }
    
    func showEmptyView() {
        navigationItem.leftBarButtonItem?.isHidden = true
        navigationItem.rightBarButtonItem?.isHidden = true
        emptyView.configure(
            message: "Упс!",
            "Похоже, Ваша корзина пуста..")
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(130)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func configureTableView() {
        tableView.presenter = presenter
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
    var clearButton: UIBarButtonItem {
        return UIBarButtonItem(
            image: .init(systemName: "trash"),
            style: .plain,
            target: self,
            action: #selector(clearAction)
        )
    }
    
    var shareButton: UIBarButtonItem {
        return UIBarButtonItem(
            image: .init(systemName: "square.and.arrow.up"),
            style: .plain,
            target: self,
            action: #selector(shareAction)
        )
    }
    
    @objc func clearAction() {
        presenter?.removeAll()
        tableView.isHidden = true
        tableView.removeFromSuperview()
        showEmptyView()
    }
    
    @objc func shareAction() {
        let items = [Any]()
        let activityVC = UIActivityViewController(
            activityItems: [items],
            applicationActivities: nil)
        present(activityVC, animated: true)
    }
    
}
