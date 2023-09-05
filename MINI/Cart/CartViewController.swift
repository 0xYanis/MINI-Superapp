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
	
	var presenter: CartPresenterProtocol?
	
	override func viewDidLoad() {
		super.viewDidLoad()
        initialize()
	}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.showTabBar()
    }
	
}

extension CartViewController: CartViewProtocol {
	
}

private extension CartViewController {
    
    func initialize() {
        
    }
    
}
