//
//  BankInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import Foundation

protocol BankInteractorProtocol: AnyObject {
    var dataSource: [BankSection] { get }
    var transactions: [Transaction] { get }
    
    func viewDidLoaded()
    func viewWillAppear()
    
    func userDidTapCard(index: Int) -> Card?
    func userDidTapSeeAll() -> [Template]
    func userDidTapTransaction(index: Int) -> Transaction?
    
    func userWantToDeleteCard(at id: Int)
    func userWantToDeleteTransaction(at id: Int)
    
    func searchBarTextDidChange(with searchText: String)
}


final class BankInteractor: BankInteractorProtocol {
    
    //MARK: - Public properties
    
    public weak var presenter: BankPresenterProtocol?
    
    public var dataSource: [BankSection] = []
    public var transactions: [Transaction] = []
    
    //MARK: - Private properties
    
    private var cardRepository: CardRepositoryProtocol
    private var templateRepository: TemplateRepositoryProtocol
    private var transacionRepository: TransactionRepositoryProtocol
    
    private var storedTransactions: [Transaction] = []
    
    //MARK: - Lifecycle
    
    init() {
        self.cardRepository = CardRepository()
        self.templateRepository = TemplateRepository()
        self.transacionRepository = TransactionRepository()
    }
    
    //MARK: - Public methods
    
    public func viewDidLoaded() {
        //api.fetch()
        getData()
        //completion:
    }
    
    func viewWillAppear() {
        getData()
    }
    
    public func userDidTapCard(index: Int) -> Card? {
        let cards = dataSource.compactMap { section -> [Card]? in
            if case .card(let cards) = section {
                return cards
            }
            return nil
        }.flatMap { $0 }
        guard cards.count > index else { return nil }
        return cards[index]
    }
    
    public func userDidTapSeeAll() -> [Template] {
        let templates = dataSource.compactMap { section -> [Template]? in
            if case .template(let templates) = section {
                return templates
            }
            return nil
        }.flatMap { $0 }
        return templates
    }
    
    public func userWantToDeleteCard(at index: Int) {
        var cards = dataSource.compactMap { section -> [Card]? in
            if case .card(let cards) = section {
                return cards
            }
            return nil
        }.flatMap { $0 }
        guard cards.count > index else { return }
        let deletedCard = cards.remove(at: index)
        dataSource[0] = .card(cards)
        
        try? cardRepository.deleteCard(deletedCard)
    }
    
    public func userDidTapTransaction(index: Int) -> Transaction? {
        if !transactions.isEmpty && transactions.count > index {
            return transactions[index]
        } else if !storedTransactions.isEmpty && storedTransactions.count > index {
            return storedTransactions[index]
        }
        return nil
    }
    
    public func userWantToDeleteTransaction(at id: Int) {
        if !transactions.isEmpty && transactions.count > id {
            let objectToRemove = transactions.remove(at: id)
            guard
                let indexToRemove = storedTransactions.firstIndex(where: { $0.id == objectToRemove.id })
            else { return }
            storedTransactions.remove(at: indexToRemove)
            try? transacionRepository.deleteTransaction(objectToRemove)
        } else if !storedTransactions.isEmpty && storedTransactions.count > id {
            let objectToRemove = storedTransactions.remove(at: id)
            try? transacionRepository.deleteTransaction(objectToRemove)
        }
    }
    
    public func searchBarTextDidChange(with searchText: String) {
        guard storedTransactions.isEmpty == false else { return }
        transactions.removeAll()
        transactions = storedTransactions.filter {
            $0.name.lowercased() == searchText.lowercased()
        }
        presenter?.updateView()
    }
    
}

//MARK: - Private methods

private extension BankInteractor {
    
    func getData() {
        // network logic
        
        fetchAll()
        presenter?.updateView()
    }
    
    func fetchAll() {
        do {
            var cards = try cardRepository.fetchCards()
            // default card for "Add new card" button
            cards.append(Card.generate())
            
            var templates = try templateRepository.fetchTemplates()
            // Default templates
            Template.examples.forEach { templates.append($0) }
            let transactions = try transacionRepository.fetchTransactions()
            dataSource = [.card(cards), .template(templates)]
            self.transactions = transactions
        } catch {
            presenter?.loadingDataGetFailed(with: error.localizedDescription)
        }
    }
    
    func fetchTransactionsFromDB() {
        do {
            let transactions = try transacionRepository.fetchTransactions()
            self.transactions = transactions
        } catch {
            presenter?.loadingDataGetFailed(with: error.localizedDescription)
        }
    }
    
}
