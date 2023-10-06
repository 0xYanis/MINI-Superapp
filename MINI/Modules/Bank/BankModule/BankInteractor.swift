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
    
    var dataSource: [BankSection] = [.card(mockCards), .template(mockTemplates)]
    
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
        switch dataSource[0] {
        case .card(let cards):
            if cards.count > index { return cards[index] }
        default: return nil
        }
        return nil
    }
    
    public func userDidTapTransaction(index: Int) -> Transaction {
        filteredData.isEmpty ? transactionsData[index] : filteredData[index]
    }
    
    public func userDidTapSeeAll() -> [Template] {
        switch dataSource[1] {
        case .template(let templates): return templates
        default: return []
        }
    }
    
    public func userWantToDeleteCard(at id: Int) {
        
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
