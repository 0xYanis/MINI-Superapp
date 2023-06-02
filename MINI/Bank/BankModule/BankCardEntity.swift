//
//  BankCardEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import Foundation
import RealmSwift

struct BankCardStruct: Codable {
    let cardList: [BankCardModel]
}

@objcMembers
final class BankCardModel: Object, Codable {
    dynamic var id        = 0
    dynamic var cardColor = ""
    dynamic var logo      = ""
    dynamic var cardType  = ""
    dynamic var amount    = 0.0
    dynamic var currency  = ""
    dynamic var number    = ""
    dynamic var bankName  = ""
    dynamic var holderName: String? = nil
    dynamic var expirationDate = ""
    dynamic var cvv       = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
