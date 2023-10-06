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
    
    func getDataSource() -> [BankSection]
    func getTransactionData() -> [Transaction]
    func getFilteredData() -> [Transaction]
    
    func userWantToDeleteCard(at id: Int)
    func userWantToDeleteTransaction(at id: Int)
    
    func searchBarTextDidChange(with searchText: String)
    
    func loadingDataGetFailed(with error: String)
}

final class BankPresenter {
    
    weak var view: BankViewProtocol?
    
    private var router: BankRouterProtocol
    private var interactor: BankInteractorProtocol
    
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
        view?.updateBankTable()
        view?.updateHistory()
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
            router.goToDetailCard(with: data!)
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
    
    func getDataSource() -> [BankSection] {
        interactor.dataSource
    }
    
    func getTransactionData() -> [Transaction] {
        interactor.transactionsData
    }
    
    func getFilteredData() -> [Transaction] {
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
