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
    func getTransactions() -> [Transaction]
    
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
// Updates view

extension BankPresenter: BankPresenterProtocol {
    
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
    
    func loadingDataGetFailed(with error: String) {
        view?.loadingDataGetFailed(with: error)
    }
    
}

// MARK: - Actions to routing

extension BankPresenter {
    
    func userWantToDetails(of type: BankViewDetails, with index: Int = 0) {
        switch type {
        case .card:
            let data = interactor.userDidTapCard(index: index)
            router.goToDetailCard(with: data!)
        case .template:
            router.goToDetailTemplate(id: index)
        case .transaction:
            guard let data = interactor.userDidTapTransaction(index: index) else { return }
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

// MARK: - User actions

extension BankPresenter {
    
    func viewDidLoaded() {
        interactor.viewDidLoaded()
    }
    
    func getDataSource() -> [BankSection] {
        interactor.dataSource
    }
    
    func getTransactions() -> [Transaction] {
        interactor.transactions
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
    
}

