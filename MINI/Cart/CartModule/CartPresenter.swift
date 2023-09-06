//
//  CartPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 05.09.2023.
//

import Foundation

protocol CartPresenterProtocol: AnyObject {
	
}

final class CartPresenter {
	
	weak var view: CartViewProtocol?
	var router: CartRouterProtocol
	var interactor: CartInteractorProtocol
	
	init(
		router: CartRouterProtocol,
		interactor: CartInteractorProtocol
	) {
		self.router = router
		self.interactor = interactor
	}
	
}

extension CartPresenter: CartPresenterProtocol {
	
}