//
//  BankTemplateEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import Foundation

final class BankTemplateObject: Codable {
    let templateList: [BankTemplateEntity]
}

struct BankTemplateEntity: Codable, Equatable {
    let id: Int
    let image: String
    let label: String
}

