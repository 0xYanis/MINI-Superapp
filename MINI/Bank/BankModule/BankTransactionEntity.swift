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

final class BankTransactionEntity: Object, Codable {
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
    
    init(id: Int, icon: String?, name: String, date: String, cost: Double, cardNumber: Int, location: String?, currency: String, status: String, category: String?, notes: String, merchantID: Int, customerID: Int) {
        self.id = id
        self.icon = icon
        self.name = name
        self.date = date
        self.cost = cost
        self.cardNumber = cardNumber
        self.location = location
        self.currency = currency
        self.status = status
        self.category = category
        self.notes = notes
        self.merchantID = merchantID
        self.customerID = customerID
    }
}
