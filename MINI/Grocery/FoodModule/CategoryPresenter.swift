//
//  CategoryPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 09.06.2023.
//

import Foundation

protocol CategoryPresenterProtocol: AnyObject {
    func updateView()
    func userDidTapProduct(index: Int)
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
    func updateView() {
        view?.udateView()
    }
    
    func userDidTapProduct(index: Int) {
        router.goToDetailProduct()
    }
    
    
}
