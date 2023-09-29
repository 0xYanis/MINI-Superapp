//
//  BankCardEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import Foundation

struct BankCardList: Codable {
    var cardList: [BankCardEntity]
}


struct BankCardEntity: Codable {
    var id: Int
    var cardColor: String
    var logo: String
    var cardType: String
    var amount: Double
    var currency: String
    var number: String
    var bankName: String
    var holderName: String?
    var expirationDate: String
    var cvv: String
}
