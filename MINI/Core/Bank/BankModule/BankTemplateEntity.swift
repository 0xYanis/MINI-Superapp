//
//  BankTemplateEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import Foundation

struct BankTemplateList: Codable {
    var templateList: [BankTemplateEntity]
}

struct BankTemplateEntity: Codable {
    var id: Int
    var image: String
    var label: String
}

