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
