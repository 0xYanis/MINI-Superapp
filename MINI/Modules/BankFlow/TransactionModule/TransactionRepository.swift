//
//  TransactionRepository.swift
//  MINI
//
//  Created by Yanis on 03.12.2023.
//

import Foundation

protocol TransactionRepositoryProtocol: AnyObject {
    func addTransaction(_ transaction: Transaction) throws
    func deleteTransaction(_ transaction: Transaction) throws
    func updateTransaction(_ transaction: Transaction) throws
    func fetchTransactions() throws -> [Transaction]
}

final class TransactionRepository: TransactionRepositoryProtocol {
    
    private let storage: RealmServiceProtocol
    
    init() {
        self.storage = RealmService()
    }
    
    func addTransaction(_ transaction: Transaction) throws {
        let object = TransactionObject(transaction)
        try storage.add(object)
    }
    
    func deleteTransaction(_ transaction: Transaction) throws {
        let object = TransactionObject(transaction)
        try storage.delete(object)
    }
    
    func updateTransaction(_ transaction: Transaction) throws {
        let object = TransactionObject(transaction)
        try storage.update(object)
    }
    
    func fetchTransactions() throws -> [Transaction] {
        let objects = try storage.fetch(TransactionObject.self)
        return objects.compactMap { Transaction($0) }
    }
    
}
