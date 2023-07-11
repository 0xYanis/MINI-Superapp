//
//  BankTransactionEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import RealmSwift

struct BankTransactionObject: Codable {
    var transactionList: [BankTransactionEntity]
}

final class BankTransactionEntity: Object, Codable {
    @Persisted var id: Int
    @Persisted var icon: String?
    @Persisted var name: String
    @Persisted var date: String
    @Persisted var cost: Double
    @Persisted var cardNumber: Int
    @Persisted var location: String?
    @Persisted var currency: String
    @Persisted var status: String
    @Persisted var category: String?
    @Persisted var notes: String
    @Persisted var merchantID: Int
    @Persisted var customerID: Int
}
