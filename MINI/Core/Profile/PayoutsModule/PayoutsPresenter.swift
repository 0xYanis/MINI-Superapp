//
//  PayoutsPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 18.08.2023.
//

import Foundation

protocol PayoutsPresenterProtocol: AnyObject {
    func setTitle(_ title: String)
    func getData() -> [PayoutsModel]
    func didTapToPush(with index: Int)
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
    
    func setTitle(_ title: String) {
        view?.setTitle(title)
    }
    
    func getData() -> [PayoutsModel] {
        interactor.getData()
    }
    
    func didTapToPush(with index: Int) {
        guard let type = type else { return }
        router.goTo(type, with: index)
    }
    
}
