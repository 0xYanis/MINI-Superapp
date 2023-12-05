//
//  BankCardEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import Foundation

fileprivate let systems = ["visa", "mastercard", "american", "mir"]
fileprivate let banks = ["Privet", "Mono", "Chester", "BooFoo"]

struct Card: Identifiable, Codable {
    var id: UUID
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
    
    static func generate() -> Card {
        
        let randomCardNumber = (0..<16).map { _ in
            String(Int.random(in: 0..<10))
        }
        
        return Card(
            id: .init(),
            cardColor: systems.randomElement() ?? "",
            logo: systems.randomElement() ?? "",
            cardType: "Classic",
            amount: Double.random(in: 1.0...9999.0),
            currency: "USD",
            number: randomCardNumber.joined(),
            bankName: banks.randomElement() ?? "",
            expirationDate: "01.01.2025",
            cvv: String(Int.random(in: 100...999)))
    }
    
}

extension Card {
    init(_ object: CardObject) {
        id = object.id
        cardColor = object.cardColor
        logo = object.logo
        cardType = object.cardType
        amount = object.amount
        currency = object.currency
        number = object.number
        bankName = object.bankName
        holderName = object.holderName
        expirationDate = object.expirationDate
        cvv = object.cvv
    }
}

extension Card {
    init(bank: String, number: String, holderName: String, cvv: String) {
        id = .init()
        cardColor = systems.randomElement() ?? ""
        logo = systems.randomElement() ?? ""
        cardType = "Classic"
        amount = Double.random(in: 1.0...9999.0)
        currency = "USD"
        self.number = number
        bankName = bank
        self.holderName = holderName
        expirationDate = "\(123)"
        self.cvv = cvv
    }
}
