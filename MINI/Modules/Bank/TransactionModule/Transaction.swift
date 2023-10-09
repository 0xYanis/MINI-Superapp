//
//  BankTransactionEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import Foundation

struct Transaction: Identifiable, Codable {
    var id = UUID().uuidString
    var icon: String?
    var name: String
    var date: String
    var cost: Double
    var cardNumber: Int
    var location: String?
    var currency: String
    var status: String
    var category: String?
    var notes: String
    var merchantID: Int
    var customerID: Int
}
