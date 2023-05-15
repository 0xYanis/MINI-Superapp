//
//  BankInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import Foundation

protocol BankInteractorProtocol: AnyObject {
    func viewDidLoaded()
    
    func getCardData() -> [BankCardEntity]
    func getTemplateData() -> [BankTemplateEntity]
    func getTransactionData() -> [BankTransactionEntity]
    
    func searchBarTextDidChange(with searchText: String)
    func getFilteredData() -> [BankTransactionEntity]
}


final class BankInteractor: BankInteractorProtocol {
    
    weak var presenter: BankPresenterProtocol?
    var cardService: BankCardServiceProtocol
    var templateService: BankTemplateServiceProtocol
    var transactionService: BankTransactionServiceProtocol
    
    private var cardsData: [BankCardEntity]               = []
    private var templatesData: [BankTemplateEntity]       = []
    private var transactionsData: [BankTransactionEntity] = []
    private var filteredData: [BankTransactionEntity]     = []
    
    
    init(
        cardService: BankCardServiceProtocol,
        templateService: BankTemplateServiceProtocol,
        transactionService: BankTransactionServiceProtocol
    ) {
        self.cardService = cardService
        self.templateService = templateService
        self.transactionService = transactionService
    }
    
    func viewDidLoaded() {
        getCards()
        getTemplates()
        getTransactions()
        presenter?.updateView()
    }
    
    func getCardData() -> [BankCardEntity] {
        return cardsData
    }
    func getTemplateData() -> [BankTemplateEntity] {
        return templatesData
    }
    func getTransactionData() -> [BankTransactionEntity] {
        return transactionsData
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
    
    func getFilteredData() -> [BankTransactionEntity] {
        return filteredData
    }
}

//MARK: - Private methods
private extension BankInteractor {
    func getCards() {
        cardService.getCardsData { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let cards):
                    self.cardsData = cards ?? []
                case .failure(let error):
                    self.presenter?.loadingDataGetFailed(with: error.localizedDescription)
                }
            }
        }
    }
    
    func getTemplates() {
        templateService.getTemplatesData { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let templates):
                    self.templatesData = templates ?? []
                case .failure(let error):
                    self.presenter?.loadingDataGetFailed(with: error.localizedDescription)
                }
            }
        }
    }
    
    func getTransactions() {
        transactionService.getTransactionsData { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let transactions):
                    self.transactionsData = transactions ?? []
                case .failure(let error):
                    self.presenter?.loadingDataGetFailed(with: error.localizedDescription)
                }
            }
        }
    }
}
