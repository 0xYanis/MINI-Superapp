//
//  CardDetailEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 25.05.2023.
//

import Foundation

struct CardDetailEntity: Codable, Equatable {
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
