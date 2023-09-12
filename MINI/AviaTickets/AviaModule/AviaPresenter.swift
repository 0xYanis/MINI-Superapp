//
//  AviaPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 03.05.2023.
//

import Foundation

protocol AviaPresenterProtocol: AnyObject {
    func getDataSource() -> [AviaSection]
}

final class AviaPresenter {
    
    weak var view: AviaViewProtocol?
    var router: AviaRouterProtocol
    var interactor: AviaInteractorProtocol
    
    init(router: AviaRouterProtocol, interactor: AviaInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension AviaPresenter: AviaPresenterProtocol {
    
    func getDataSource() -> [AviaSection] {
        interactor.dataSource
    }
    
}
