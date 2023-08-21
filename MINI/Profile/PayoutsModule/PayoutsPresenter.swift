//
//  PayoutsPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 18.08.2023.
//

import Foundation

protocol PayoutsPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func setTitle(_ title: String)
    func setData(with data: [PayoutsModel])
}

final class PayoutsPresenter: PayoutsPresenterProtocol {
    
    weak var view: PayoutsViewProtocol?
    var router: PayoutsRouterProtocol
    var interactor: PayoutsInteractorProtocol
    var type: PayoutsType? {
        didSet {
            switch type {
            case .tickets: view?.setTitle("Билеты")
            case .favorites: view?.setTitle("Избранное")
            case .orders: view?.setTitle("Заказы")
            case .transactions: view?.setTitle("Покупки")
            default: view?.setTitle("")
            }
        }
    }
    
    init(
        router: PayoutsRouterProtocol,
        interactor: PayoutsInteractorProtocol
    ) {
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoaded() {
        interactor.viewDidLoaded()
    }
    
    func setTitle(_ title: String) {
        view?.setTitle(title)
    }
    
    func setData(with data: [PayoutsModel]) {
        view?.setView(with: data)
    }
    
}
