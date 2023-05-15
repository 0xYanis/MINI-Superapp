//
//  BankPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import Foundation

protocol BankPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func userDidTapNewCard()
    func userDidTapNewTemplate()
    func userDidTapCard(id: Int)
    func userDidTapSeeAll()
    func userDidTapTemplate(id: Int)
    func userDidTapTransaction(id: Int)
    func setNewCard()
    func setNewTransaction()
    
    func getCardData() -> [BankCardEntity]
    func getTemplateData() -> [BankTemplateEntity]
    func getTransactionData() -> [BankTransactionEntity]
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
    
    func userDidTapNewCard() {
        router.goToAddNewCard()
    }
    
    func userDidTapNewTemplate() {
        router.goToAddNewTemplate()
    }
    
    func userDidTapCard(id: Int) {
        router.goToDetailCard(id: id)
    }
    
    func userDidTapSeeAll() {
        router.goToAllTemplates()
    }
    
    func userDidTapTemplate(id: Int) {
        router.goToDetailTemplate(id: id)
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
    
    func getCardData() -> [BankCardEntity] {
        interactor.getCardData()
    }
    
    func getTemplateData() -> [BankTemplateEntity] {
        interactor.getTemplateData()
    }
    
    func getTransactionData() -> [BankTransactionEntity] {
        interactor.getTransactionData()
    }
}
