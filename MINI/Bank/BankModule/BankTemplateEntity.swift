//
//  BankTemplateEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import RealmSwift

struct BankTemplateObject: Codable {
    var templateList: [BankTemplateEntity]
}

final class BankTemplateEntity: Object, Codable {
    @Persisted var id: Int
    @Persisted var image: String
    @Persisted var label: String
}

