//
//  BankInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import Foundation

protocol BankInteractorProtocol: AnyObject {
    var dataSource: [BankSection] { get }
    var transactionsData: [Transaction] { get }
    var filteredData: [Transaction] { get }
    
    func viewDidLoaded()
    
    func userDidTapCard(index: Int) -> Card?
    func userDidTapSeeAll() -> [Template]
    func userDidTapTransaction(index: Int) -> Transaction
    
    func userWantToDeleteCard(at id: Int)
    func userWantToDeleteTransaction(at id: Int)
    
    func searchBarTextDidChange(with searchText: String)
}


final class BankInteractor: BankInteractorProtocol {
    
    //MARK: - Public properties
    
    weak var presenter: BankPresenterProtocol?
    
    var dataSource: [BankSection] = [.card(mockCards), .template(mockTemplates), .transfer(mockTransfers)]
    
    var transactionsData: [Transaction] = []
    var filteredData: [Transaction]     = []
    
    //MARK: - Private properties
    
    private var realmService: RealmServiceProtocol?
    
    //MARK: - Init
    
    init(realmService: RealmServiceProtocol = RealmService()) {
        self.realmService = realmService
    }
    
    //MARK: - Public methods
    
    public func viewDidLoaded() {
        
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
    
    public func userDidTapTransaction(index: Int) -> Transaction {
        filteredData.isEmpty ? transactionsData[index] : filteredData[index]
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
    
}
