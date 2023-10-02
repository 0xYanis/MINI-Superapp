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
    func userDidTapTransaction(index: Int) -> BankTransactionEntity
    
    func userWantToDeleteCard(at id: Int)
    func userWantToDeleteTransaction(at id: Int)
    
    func searchBarTextDidChange(with searchText: String)
}


final class BankInteractor: BankInteractorProtocol {
    
    //MARK: - Public properties
    
    weak var presenter: BankPresenterProtocol?
    
    var cardsData: [BankCardEntity]               = []
    var templatesData: [BankTemplateEntity]       = []
    var transactionsData: [BankTransactionEntity] = []
    var filteredData: [BankTransactionEntity]     = []
    
    //MARK: - Private properties
    
    private var cardService: BankCardServiceProtocol
    private var templateService: BankTemplateServiceProtocol
    private var transactionService: BankTransactionServiceProtocol
    private var realmService: RealmServiceProtocol?
    
    //MARK: - Init
    
    init(
        realmService: RealmServiceProtocol = RealmService(),
        cardService: BankCardServiceProtocol,
        templateService: BankTemplateServiceProtocol,
        transactionService: BankTransactionServiceProtocol
    ) {
        self.realmService = realmService
        self.cardService = cardService
        self.templateService = templateService
        self.transactionService = transactionService
    }
    
    //MARK: - Public methods
    
    public func viewDidLoaded() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.getCards()
            self.getTemplates()
            self.getTransactions()
        }
    }
    
    public func userDidTapCard(index: Int) -> BankCardEntity {
        return cardsData[index]
    }
    
    public func userDidTapTransaction(index: Int) -> BankTransactionEntity {
        filteredData.isEmpty ? transactionsData[index] : filteredData[index]
    }
    
    public func userDidTapSeeAll() -> [BankTemplateEntity] {
        return templatesData
    }
    
    public func userWantToDeleteCard(at id: Int) {
        if !cardsData.isEmpty {
            cardsData.remove(at: id)
        }
    }
    
    public func userWantToDeleteTransaction(at id: Int) {
        if !filteredData.isEmpty {
            filteredData.remove(at: id)
            return
        }
        if !transactionsData.isEmpty {
            transactionsData.remove(at: id)
            return
        }
    }
    
    public func searchBarTextDidChange(with searchText: String) {
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
            switch result {
            case .success(let cards):
                guard let cards else { return }
                self.cardsData = cards
                DispatchQueue.main.async {
                    self.presenter?.updateView()
                }
            case .failure(let error):
                self.presenter?.loadingDataGetFailed(
                    with: error.localizedDescription
                )
            }
        }
    }
    
    func getTemplates() {
        templateService.getTemplatesData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let templates):
                guard let templates else { return }
                self.templatesData = templates
                DispatchQueue.main.async {
                    self.presenter?.updateView()
                }
            case .failure(let error):
                self.presenter?.loadingDataGetFailed(
                    with: error.localizedDescription
                )
            }
        }
    }
    
    func getTransactions() {
        transactionService.getTransactionsData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let transactions):
                guard let transactions else { return }
                self.transactionsData = transactions
                DispatchQueue.main.async {
                    self.presenter?.updateView()
                }
            case .failure(let error):
                self.presenter?.loadingDataGetFailed(
                    with: error.localizedDescription
                )
            }
        }
    }
    
}
