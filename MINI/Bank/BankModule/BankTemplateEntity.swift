//
//  BankTemplateEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import Foundation
import RealmSwift

struct BankTemplateStruct: Codable, Equatable {
    let templateList: [BankTemplateEntity]
}

struct BankTemplateEntity: Codable, Equatable {
    let id: Int
    let image: String
    let label: String
}


@objcMembers
final class BankTemplateModel: Object {
    dynamic var id    = ""
    dynamic var image = ""
    dynamic var label = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
