//
//  PayoutsPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 18.08.2023.
//

import Foundation

protocol PayoutsPresenterProtocol: AnyObject {
    func viewDidLoaded()
}

final class PayoutsPresenter: PayoutsPresenterProtocol {
    
    weak var view: PayoutsViewProtocol?
    var router: PayoutsRouterProtocol
    var interactor: PayoutsInteractorProtocol
    
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
    
}
