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

@objcMembers
final class BankTransactionEntity: Object, Codable {
    dynamic var id: Int = 0
    dynamic var icon: String? = ""
    dynamic var name: String = ""
    dynamic var date: String = ""
    dynamic var cost: Double = 0.0
    dynamic var cardNumber: Int = 0
    dynamic var location: String? = ""
    dynamic var currency: String = ""
    dynamic var status: String = ""
    dynamic var category: String? = ""
    dynamic var notes: String = ""
    dynamic var merchantID: Int = 0
    dynamic var customerID: Int = 0
}
