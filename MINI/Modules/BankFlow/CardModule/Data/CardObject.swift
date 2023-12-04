//
//  CardObject.swift
//  MINI
//
//  Created by Yanis on 04.12.2023.
//

import Foundation
import RealmSwift

class CardObject: Object, Identifiable {
    @Persisted(primaryKey: true) var id: UUID
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

extension CardObject {
    convenience init(_ dto: Card) {
        self.init()
        id = dto.id
        cardColor = dto.cardColor
        logo = dto.logo
        cardType = dto.cardType
        amount = dto.amount
        currency = dto.currency
        number = dto.number
        bankName = dto.bankName
        holderName = dto.holderName
        expirationDate = dto.expirationDate
        cvv = dto.cvv
    }
}
