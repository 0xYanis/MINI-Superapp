//
//  BankPresenter.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import Foundation

protocol BankPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func updateView()
    func userDidTapNewCard()
    func userDidTapNewTemplate()
    func userDidTapCard(index: Int)
    func userDidTapSeeAll()
    func userDidTapTemplate(id: Int)
    func userDidTapTransaction(id: Int)
    func setNewCard()
    func setNewTransaction()
    
    func getCardData() -> [BankCardEntity]
    func getTemplateData() -> [BankTemplateEntity]
    func getTransactionData() -> [BankTransactionEntity]
    
    func userWantToDeleteCard(at id: Int)
    func userWantToDeleteTransaction(at id: Int)
    
    func searchBarTextDidChange(with searchText: String)
    func getFilteredData() -> [BankTransactionEntity]
    
    func loadingDataGetFailed(with error: String)
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
    
    func updateView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.updateBankTable()
            self.view?.updateHistory()
        }
    }
    
    func userDidTapNewCard() {
        router.goToAddNewCard()
    }
    
    func userDidTapNewTemplate() {
        router.goToAddNewTemplate()
    }
    
    func userDidTapCard(index: Int) {
        let data = interactor.userDidTapCard(index: index)
        router.goToDetailCard(with: data)
    }
    
    func userDidTapSeeAll() {
        let data = interactor.userDidTapSeeAll()
        router.goToAllTemplates(with: data)
    }
    
    func userDidTapTemplate(id: Int) {
        router.goToDetailTemplate(id: id)
    }
    
    func userDidTapTransaction(id: Int) {
        router.goToDetailTransaction(id: id)
    }
    
    func setNewCard() {
        view?.updateBankTable()
    }
    
    func setNewTransaction() {
        view?.updateHistory()
    }
    
    func getCardData() -> [BankCardEntity] {
        interactor.cardsData
    }
    
    func getTemplateData() -> [BankTemplateEntity] {
        interactor.templatesData
    }
    
    func getTransactionData() -> [BankTransactionEntity] {
        interactor.transactionsData
    }
    
    func userWantToDeleteCard(at id: Int) {
        interactor.userWantToDeleteCard(at: id)
    }
    
    func userWantToDeleteTransaction(at id: Int) {
        interactor.userWantToDeleteTransaction(at: id)
    }
    
    func searchBarTextDidChange(with searchText: String) {
        interactor.searchBarTextDidChange(with: searchText)
    }
    
    func getFilteredData() -> [BankTransactionEntity] {
        interactor.filteredData
    }
    
    func loadingDataGetFailed(with error: String) {
        view?.loadingDataGetFailed(with: error)
    }
}
