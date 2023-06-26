//
//  BankCardEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import RealmSwift

final class BankCardObject: Object, Codable {
    let cardList: [BankCardEntity]
}

final class BankCardEntity: Object, Codable {
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
    
    init(id: Int, cardColor: String, logo: String, cardType: String, amount: Double, currency: String, number: String, bankName: String, holderName: String?, expirationDate: String, cvv: String) {
        self.id = id
        self.cardColor = cardColor
        self.logo = logo
        self.cardType = cardType
        self.amount = amount
        self.currency = currency
        self.number = number
        self.bankName = bankName
        self.holderName = holderName
        self.expirationDate = expirationDate
        self.cvv = cvv
    }
}
