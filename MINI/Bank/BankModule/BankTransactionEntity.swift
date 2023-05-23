//
//  BankTransactionEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import Foundation
import RealmSwift

struct BankTransactionEntity: Codable, Equatable {
    let id: Int
    let icon: String
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

@objcMembers
final class BankTransactionModel: Object {
    dynamic var id: Int = 0
    dynamic var icon: String      = ""
    dynamic var name: String      = ""
    dynamic var date: String      = ""
    dynamic var cost: Double      = 0.0
    dynamic var cardNumber: Int   = 0
    dynamic var location: String? = nil
    dynamic var currency: String  = ""
    dynamic var status: String    = ""
    dynamic var category: String? = nil
    dynamic var notes: String     = ""
    dynamic var merchantID: Int   = 0
    dynamic var customerID: Int   = 0

    override class func primaryKey() -> String? {
        return "id"
    }
}

