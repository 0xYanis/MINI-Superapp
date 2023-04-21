//
//  BankPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import Foundation

protocol BankPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func userDidTapCard(id: Int)
    func userDidTapSeeAll()
    func userDidTapTransaction(id: Int)
    func setNewCard()
    func setNewTransaction()
}

final class BankPresenter {
    
    weak var view: BankViewProtocol?
    let router: BankRouterProtocol
    let interactor: BankInteractorProtocol
    
    init(router: BankRouterProtocol, interactor: BankInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension BankPresenter: BankPresenterProtocol {
    func viewDidLoaded() {
        interactor.viewDidLoaded()
    }
    
    func userDidTapCard(id: Int) {
        router.goToDetailCard(id: id)
    }
    
    func userDidTapSeeAll() {
        router.goToAllTemplates()
    }
    
    func userDidTapTransaction(id: Int) {
        router.goToDetailTransaction(id: id)
    }
    
    func setNewCard() {
        view?.updateCards()
    }
    
    func setNewTransaction() {
        view?.updateHistory()
    }
}
