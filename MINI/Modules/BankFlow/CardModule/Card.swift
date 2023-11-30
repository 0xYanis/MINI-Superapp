//
//  BankCardEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import Foundation
import RealmSwift

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
    
    static func convertToCardStruct(cardObject: CardObject) -> Card {
        return Card(id: cardObject.id,
                    cardColor: cardObject.cardColor,
                    logo: cardObject.logo,
                    cardType: cardObject.cardType,
                    amount: cardObject.amount,
                    currency: cardObject.currency,
                    number: cardObject.number,
                    bankName: cardObject.bankName,
                    holderName: cardObject.holderName,
                    expirationDate: cardObject.expirationDate,
                    cvv: cardObject.cvv)
    }
}

class CardObject: Object, Identifiable {
    @Persisted var id = UUID().uuidString
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
    
    class func convertToCardObject(card: Card) -> CardObject {
        let cardObject = CardObject()
        
        cardObject.id = card.id
        cardObject.cardColor = card.cardColor
        cardObject.logo = card.logo
        cardObject.cardType = card.cardType
        cardObject.amount = card.amount
        cardObject.currency = card.currency
        cardObject.number = card.number
        cardObject.bankName = card.bankName
        cardObject.holderName = card.holderName
        cardObject.expirationDate = card.expirationDate
        cardObject.cvv = card.cvv
        
        return cardObject
    }
}

var mockCards: [Card] = [
    .init(cardColor: "mastercard", logo: "mastercard", cardType: "mastercard", amount: 10.0, currency: "USD", number: "1111222233334444", bankName: "OTP", expirationDate: "02.02.23", cvv: "432"),
    .init(cardColor: "mastercard", logo: "mastercard", cardType: "mastercard", amount: 10.0, currency: "USD", number: "1111222233334444", bankName: "OTP", expirationDate: "02.02.23", cvv: "432"),
    .init(cardColor: "mastercard", logo: "mastercard", cardType: "mastercard", amount: 10.0, currency: "USD", number: "1111222233334444", bankName: "OTP", expirationDate: "02.02.23", cvv: "432"),
    .init(cardColor: "mastercard", logo: "mastercard", cardType: "mastercard", amount: 10.0, currency: "USD", number: "1111222233334444", bankName: "OTP", expirationDate: "02.02.23", cvv: "432"),
    .init(cardColor: "mastercard", logo: "mastercard", cardType: "mastercard", amount: 10.0, currency: "USD", number: "1111222233334444", bankName: "OTP", expirationDate: "02.02.23", cvv: "432"),
    .init(cardColor: "mastercard", logo: "mastercard", cardType: "mastercard", amount: 10.0, currency: "USD", number: "1111222233334444", bankName: "OTP", expirationDate: "02.02.23", cvv: "432"),
    // empty card
    .init(cardColor: "", logo: "", cardType: "", amount: 0.0, currency: "", number: "", bankName: "", expirationDate: "", cvv: "")
]
