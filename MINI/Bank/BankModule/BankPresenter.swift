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
    func setNewCard()
    func setNewTransaction()
    
    func userWantToDetails(of type: BankViewDetails, with index: Int)
    
    func getCardData() -> [BankCardEntity]
    func getTemplateData() -> [BankTemplateEntity]
    func getTransactionData() -> [BankTransactionEntity]
    func getFilteredData() -> [BankTransactionEntity]
    
    func userWantToDeleteCard(at id: Int)
    func userWantToDeleteTransaction(at id: Int)
    
    func searchBarTextDidChange(with searchText: String)
    
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

// MARK: - BankPresenterProtocol
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
    
    func setNewCard() {
        view?.updateBankTable()
    }
    
    func setNewTransaction() {
        view?.updateHistory()
    }
    
}

// MARK: - Routing
extension BankPresenter {
    func userWantToDetails(of type: BankViewDetails, with index: Int = 0) {
        switch type {
        case .card:
            let data = interactor.userDidTapCard(index: index)
            router.goToDetailCard(with: data)
        case .template:
            router.goToDetailTemplate(id: index)
        case .transaction:
            let data = interactor.userDidTapTransaction(index: index)
            router.goToDetailTransaction(with: data)
        case .allTransactions:
            let data = interactor.userDidTapSeeAll()
            router.goToAllTemplates(with: data)
        case .newCard:
            router.goToAddNewCard()
        case .newTemplate:
            router.goToAddNewTemplate()
        }
    }
    
}

// MARK: - GET data
extension BankPresenter {
    func getCardData() -> [BankCardEntity] {
        interactor.cardsData
    }
    
    func getTemplateData() -> [BankTemplateEntity] {
        interactor.templatesData
    }
    
    func getTransactionData() -> [BankTransactionEntity] {
        interactor.transactionsData
    }
    
    func getFilteredData() -> [BankTransactionEntity] {
        interactor.filteredData
    }
    
}

extension BankPresenter {
    func userWantToDeleteCard(at id: Int) {
        interactor.userWantToDeleteCard(at: id)
    }
    
    func userWantToDeleteTransaction(at id: Int) {
        interactor.userWantToDeleteTransaction(at: id)
    }
    
    func searchBarTextDidChange(with searchText: String) {
        interactor.searchBarTextDidChange(with: searchText)
    }
    
    func loadingDataGetFailed(with error: String) {
        view?.loadingDataGetFailed(with: error)
    }
    
}
