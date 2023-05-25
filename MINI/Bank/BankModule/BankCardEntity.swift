//
//  BankCardEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import Foundation
import RealmSwift

struct BankCardStruct: Codable, Equatable {
    let cardList: [BankCardEntity]
}

struct BankCardEntity: Codable, Equatable {
    let id: Int
    let cardColor: String
    let logo: String
    let cardType: String
    let amount: Double
    let currency: String
    let number: String
    let bankName: String
    let holderName: String?
    let expirationDate: String
    let cvv: String
}

@objcMembers
final class BankCardModel: Object {
    dynamic var id        = 0
    dynamic var cardColor = ""
    dynamic var logo      = ""
    dynamic var cardType  = ""
    dynamic var amount    = 0.0
    dynamic var number    = ""
    dynamic var bankName  = ""
    dynamic var holderName: String? = nil
    dynamic var expirationDate = ""
    dynamic var cvv       = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

