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
        configureTableView()
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
        
    }
    
    @objc func shareAction() {
        
    }
    
}
