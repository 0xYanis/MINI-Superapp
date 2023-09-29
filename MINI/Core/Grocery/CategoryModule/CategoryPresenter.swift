//
//  CategoryPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 09.06.2023.
//

import Foundation

protocol CategoryPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func updateView()
    
    func userDidTapProduct(index: Int)
    func userDidTapSearchProduct()
    
    func userAddProductToCart(section: Int, index: Int)
    func updateCart(with totalCost: Double)
    
    func userDidTapCart()
}

final class CategoryPresenter {
    
    weak var view: CategoryViewProtocol?
    var router: CategoryRouterProtocol
    var interactor: CategoryInteractorProtocol
    
    init(
        router: CategoryRouterProtocol,
        interactor: CategoryInteractorProtocol
    ) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension CategoryPresenter: CategoryPresenterProtocol {
    func viewDidLoaded() {
        interactor.viewDidLoaded()
    }
    
    func updateView() {
        view?.udateView()
    }
    
    func userDidTapProduct(index: Int) {
        router.goToDetailProduct(index: index)
    }
    
    func userDidTapSearchProduct() {
        router.goToSearchView()
    }
    
    func userAddProductToCart(section: Int, index: Int) {
        interactor.userAddProductToCart(section, index)
    }
    
    func updateCart(with totalCost: Double) {
        view?.updateCart(with: totalCost)
    }
    
    func userDidTapCart() {
        router.goToCart()
    }
    
}
