//
//  BankTemplateEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import RealmSwift

@objcMembers
final class BankTemplateObject: Object, Codable {
    dynamic var templateList: [BankTemplateEntity]
}

@objcMembers
final class BankTemplateEntity: Object, Codable {
    dynamic var id: Int = 0
    dynamic var image: String = ""
    dynamic var label: String = ""
}

