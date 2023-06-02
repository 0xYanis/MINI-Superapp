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
    
    init(from bankCardModel: BankCardModel) {
        self.id = bankCardModel.id
        self.cardColor = bankCardModel.cardColor
        self.logo = bankCardModel.logo
        self.cardType = bankCardModel.cardType
        self.amount = bankCardModel.amount
        self.currency = bankCardModel.currency
        self.number = bankCardModel.number
        self.bankName = bankCardModel.bankName
        self.holderName = bankCardModel.holderName
        self.expirationDate = bankCardModel.expirationDate
        self.cvv = bankCardModel.cvv
    }
}

extension BankCardEntity {
    func toModel() -> BankCardModel {
        let model = BankCardModel()
        model.id = id
        model.cardColor = cardColor
        model.logo = logo
        model.cardType = cardType
        model.amount = amount
        model.currency = currency
        model.number = number
        model.bankName = bankName
        model.holderName = holderName
        model.expirationDate = expirationDate
        model.cvv = cvv
        return model
    }
}

@objcMembers
final class BankCardModel: Object {
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
