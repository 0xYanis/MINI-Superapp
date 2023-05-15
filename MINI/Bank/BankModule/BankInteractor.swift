//
//  BankInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import Foundation

protocol BankInteractorProtocol: AnyObject {
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
    
    
    func getCardData() -> [BankCardEntity] {
        cardService.getCardsData { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let cards):
                    self.cardsData = cards ?? []
                    self.presenter?.viewDidLoaded()
                case .failure(let error):
                    self.presenter?.loadingDataGetFailed(with: error.localizedDescription)
                }
            }
        }
        return cardsData
    }
    
    func getTemplateData() -> [BankTemplateEntity] {
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
        return templatesData
    }
    
    func getTransactionData() -> [BankTransactionEntity] {
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
        presenter?.viewDidLoaded()
    }
    
    func getFilteredData() -> [BankTransactionEntity] {
        return filteredData
    }
}
