//
//  BankTemplateEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import RealmSwift

final class BankTemplateObject: Object, Codable {
    let templateList: [BankTemplateEntity]
}

final class BankTemplateEntity: Object, Codable {
    let id: Int
    let image: String
    let label: String
}

