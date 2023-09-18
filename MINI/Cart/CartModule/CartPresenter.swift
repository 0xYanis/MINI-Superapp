//
//  CartPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 05.09.2023.
//

import Foundation

protocol CartPresenterProtocol: AnyObject {
    func getPurchases() -> [Purchase]
	func getTagItems() -> [String]
    func setCurrentTag(_ index: Int)
    
    func deleteCell(at index: Int)
    func removeAll()
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
	
    func getPurchases() -> [Purchase] {
        interactor.purchases
    }
    
    func getTagItems() -> [String] {
        interactor.tagItems
    }
    
    func setCurrentTag(_ index: Int) {
        interactor.setCurrentTag(index)
    }
    
    func deleteCell(at index: Int) {
        interactor.deleteCell(at: index)
    }
    
    func removeAll() {
        interactor.removeAll()
    }
    
}
