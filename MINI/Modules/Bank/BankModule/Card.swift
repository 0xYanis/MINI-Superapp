//
//  BankCardEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import Foundation

struct Card: Identifiable, Codable {
    var id = UUID().uuidString
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

var mockCards: [Card] = [
    .init(cardColor: "mastercard", logo: "mastercard", cardType: "mastercard", amount: 10.0, currency: "USD", number: "1111222233334444", bankName: "OTP", expirationDate: "02.02.23", cvv: "432"),
    .init(cardColor: "mastercard", logo: "mastercard", cardType: "mastercard", amount: 10.0, currency: "USD", number: "1111222233334444", bankName: "OTP", expirationDate: "02.02.23", cvv: "432"),
    .init(cardColor: "mastercard", logo: "mastercard", cardType: "mastercard", amount: 10.0, currency: "USD", number: "1111222233334444", bankName: "OTP", expirationDate: "02.02.23", cvv: "432"),
    .init(cardColor: "mastercard", logo: "mastercard", cardType: "mastercard", amount: 10.0, currency: "USD", number: "1111222233334444", bankName: "OTP", expirationDate: "02.02.23", cvv: "432"),
    .init(cardColor: "mastercard", logo: "mastercard", cardType: "mastercard", amount: 10.0, currency: "USD", number: "1111222233334444", bankName: "OTP", expirationDate: "02.02.23", cvv: "432"),
    .init(cardColor: "mastercard", logo: "mastercard", cardType: "mastercard", amount: 10.0, currency: "USD", number: "1111222233334444", bankName: "OTP", expirationDate: "02.02.23", cvv: "432")
]
