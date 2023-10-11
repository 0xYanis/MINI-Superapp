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
    public var dataSource: [BankSection] = [.card(mockCards), .template(mockTemplates), .transfer(mockTransfers)]
    public var transactions: [Transaction] = []
    
    //MARK: - Private properties
    
    private var realmService: RealmServiceProtocol?
    private var storedTransactions: [Transaction] = []
    
    //MARK: - Init
    
    init(realmService: RealmServiceProtocol = RealmService()) {
        self.realmService = realmService
    }
    
    //MARK: - Public methods
    
    public func viewDidLoaded() {
        //api.fetch()
        //completion:
        presenter?.updateView()
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
        cards.remove(at: index)
        dataSource[0] = .card(cards)
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
            var objectToRemove = transactions.remove(at: id)
            guard
                let indexToRemove = storedTransactions.firstIndex(where: { $0.id == objectToRemove.id })
            else { return }
            storedTransactions.remove(at: indexToRemove)
        } else if !storedTransactions.isEmpty && storedTransactions.count > id {
            storedTransactions.remove(at: id)
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
    
}
