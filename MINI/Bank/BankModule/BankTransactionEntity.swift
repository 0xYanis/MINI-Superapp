//
//  BankTransactionEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import Foundation

struct BankTransactionEntity: Codable, Equatable {
    let icon: String
    let name: String
    let date: String
    let cost: String
    let cardNumber: String
}
