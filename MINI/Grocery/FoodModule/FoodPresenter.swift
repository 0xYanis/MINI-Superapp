//
//  FoodPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 09.06.2023.
//

import Foundation

protocol FoodPresenterProtocol: AnyObject {
    func updateView()
    func userDidTapProduct(index: Int)
}

final class FoodPresenter {
    
    weak var view: FoodViewProtocol?
    var router: FoodRouterProtocol
    var interactor: FoodInteractorProtocol
    
    init(
        router: FoodRouterProtocol,
        interactor: FoodInteractorProtocol
    ) {
        self.router = router
        self.interactor = interactor
    }
}

extension FoodPresenter: FoodPresenterProtocol {
    func updateView() {
        view?.udateView()
    }
    
    func userDidTapProduct(index: Int) {
        router.goToDetailProduct()
    }
    
    
}
