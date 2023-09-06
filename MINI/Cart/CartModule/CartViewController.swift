//
//  CartViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 05.09.2023.
//

import UIKit

protocol CartViewProtocol: AnyObject {
	
}

final class CartViewController: UIViewController {
	
    // MARK: - Public properties
    
	public var presenter: CartPresenterProtocol?
    
    // MARK: - Private properties
    
    private var collectionView: UICollectionView!
    private var leftButton: UIBarButtonItem!
    private var rightButton: UIBarButtonItem!
	
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
        view.backgroundColor = .back2MINI
    }
    
}
