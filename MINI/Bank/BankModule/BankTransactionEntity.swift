//
//  BankTransactionEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import RealmSwift

final class BankTransactionObject: Object, Codable {
    let transactionList: [BankTransactionEntity]
}

struct BankTransactionEntity: Codable, Equatable {
    let id: Int
    let icon: String?
    let name: String
    let date: String
    let cost: Double
    let cardNumber: Int
    let location: String?
    let currency: String
    let status: String
    let category: String?
    let notes: String
    let merchantID: Int
    let customerID: Int
}
