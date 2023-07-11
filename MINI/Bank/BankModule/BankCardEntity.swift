//
//  BankCardEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import RealmSwift

struct BankCardObject: Codable {
    var cardList: [BankCardEntity]
}


final class BankCardEntity: Object, Codable {
    @Persisted var id: Int
    @Persisted var cardColor: String
    @Persisted var logo: String
    @Persisted var cardType: String
    @Persisted var amount: Double
    @Persisted var currency: String
    @Persisted var number: String
    @Persisted var bankName: String
    @Persisted var holderName: String?
    @Persisted var expirationDate: String
    @Persisted var cvv: String
}
