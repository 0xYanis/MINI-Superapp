//
//  BankInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import Foundation

protocol BankInteractorProtocol: AnyObject {
    var cardsData: [BankCardEntity] { get }
    var templatesData: [BankTemplateEntity] { get }
    var transactionsData: [BankTransactionEntity] { get }
    var filteredData: [BankTransactionEntity] { get }
    
    func viewDidLoaded()
    
    func userDidTapCard(index: Int) -> BankCardEntity
    func userDidTapSeeAll() -> [BankTemplateEntity]
    
    func userWantToDeleteCard(at id: Int)
    func userWantToDeleteTransaction(at id: Int)
    
    func searchBarTextDidChange(with searchText: String)
}


final class BankInteractor: BankInteractorProtocol {
    
    weak var presenter: BankPresenterProtocol?
    var realmService: RealmServiceProtocol
    var cardService: BankCardServiceProtocol
    var templateService: BankTemplateServiceProtocol
    var transactionService: BankTransactionServiceProtocol
    
    var cardsData: [BankCardEntity]               = []
    var templatesData: [BankTemplateEntity]       = []
    var transactionsData: [BankTransactionEntity] = []
    var filteredData: [BankTransactionEntity]     = []
    
    
    init(
        realmService: RealmServiceProtocol,
        cardService: BankCardServiceProtocol,
        templateService: BankTemplateServiceProtocol,
        transactionService: BankTransactionServiceProtocol
    ) {
        self.realmService = realmService
        self.cardService = cardService
        self.templateService = templateService
        self.transactionService = transactionService
    }
    
    func viewDidLoaded() {
        getCards()
        getTemplates()
        getTransactions()
    }
    
    func userDidTapCard(index: Int) -> BankCardEntity {
        return cardsData[index]
    }
    
    func userDidTapSeeAll() -> [BankTemplateEntity] {
        return templatesData
    }
    
    func userWantToDeleteCard(at id: Int) {
        cardsData.remove(at: id)
    }
    
    func userWantToDeleteTransaction(at id: Int) {
        if !filteredData.isEmpty {
            filteredData.remove(at: id)
        }
        if !transactionsData.isEmpty {
            transactionsData.remove(at: id)
        }
    }
    
    func searchBarTextDidChange(with searchText: String) {
        if searchText.isEmpty {
            filteredData.removeAll()
        } else {
            filteredData = transactionsData.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
        presenter?.updateView()
    }
}

//MARK: - Private methods
private extension BankInteractor {
    func getCards() {
        cardService.getCardsData { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.global().async {
                switch result {
                case .success(let cards):
                    self.cardsData = cards ?? []
                    self.presenter?.updateView()
                case .failure(let error):
                    self.presenter?.loadingDataGetFailed(with: error.localizedDescription)
                }
            }
        }
    }
    
    func getTemplates() {
        templateService.getTemplatesData { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.global().async {
                switch result {
                case .success(let templates):
                    self.templatesData = templates ?? []
                    self.presenter?.updateView()
                case .failure(let error):
                    self.presenter?.loadingDataGetFailed(with: error.localizedDescription)
                }
            }
        }
    }
    
    func getTransactions() {
        transactionService.getTransactionsData { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.global().async {
                switch result {
                case .success(let transactions):
                    self.transactionsData = transactions ?? []
                    self.presenter?.updateView()
                case .failure(let error):
                    self.presenter?.loadingDataGetFailed(with: error.localizedDescription)
                }
            }
        }
    }
}
