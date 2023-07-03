//
//  CartPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 03.07.2023.
//

import Foundation

protocol CartPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func hideCart(_ isHidden: Bool)
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
    func viewDidLoaded() {
        interactor.viewDidLoaded()
    }
    
    func hideCart(_ isHidden: Bool) {
        view?.cartIsEmpty = isHidden
    }
}
