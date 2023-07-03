//
//  BankCardEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import RealmSwift

final class BankCardObject: Codable {
    var cardList: [BankCardEntity]
}

@objcMembers
final class BankCardEntity: Object, Codable {
    dynamic var id: Int = 0
    dynamic var cardColor: String = ""
    dynamic var logo: String = ""
    dynamic var cardType: String = ""
    dynamic var amount: Double = 0.0
    dynamic var currency: String  = ""
    dynamic var number: String = ""
    dynamic var bankName: String = ""
    dynamic var holderName: String? = ""
    dynamic var expirationDate: String = ""
    dynamic var cvv: String = ""
}
