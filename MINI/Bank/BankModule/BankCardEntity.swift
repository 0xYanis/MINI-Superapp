//
//  BankCardEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import Foundation

struct BankCardEntity: Codable, Equatable {
    let cardColor: String
    let logo: String
    let amount: String
    let number: String
}
