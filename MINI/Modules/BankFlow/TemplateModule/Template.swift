//
//  BankTemplateEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import Foundation
import RealmSwift

struct Template: Identifiable, Codable {
    var id = UUID().uuidString
    var image: String
    var label: String
}

extension Template {
    init(_ object: TemplateObject) {
        id = object.id
        image = object.image
        label = object.label
    }
}

class TemplateObject: Object {
    @Persisted var id = UUID().uuidString
    @Persisted var image: String
    @Persisted var label: String
}

extension TemplateObject {
    convenience init(_ dto: Template) {
        self.init()
        id = dto.id
        image = dto.image
        label = dto.label
    }
}
