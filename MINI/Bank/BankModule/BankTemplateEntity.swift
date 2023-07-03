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

@objcMembers
final class BankTemplateEntity: Object, Codable {
    dynamic var id: Int = 0
    dynamic var image: String = ""
    dynamic var label: String = ""
}

