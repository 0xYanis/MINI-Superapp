//
//  ProductPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 12.06.2023.
//

import Foundation

protocol ProductPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func updateView()
}

final class ProductPresenter {
    
    weak var view: ProductViewProtocol?
    var router: ProductRouterProtocol
    var interactor: ProductInteractorProtocol
    
    init(
        router: ProductRouterProtocol,
        interactor: ProductInteractorProtocol
    ) {
        self.router = router
        self.interactor = interactor
    }
}

extension ProductPresenter: ProductPresenterProtocol {
    func viewDidLoaded() {
        interactor.viewDidLoaded()
    }
    
    func updateView() {
        view?.updateView()
    }
}
